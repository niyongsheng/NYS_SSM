import com.intellij.database.model.DasTable
import com.intellij.database.util.Case
import com.intellij.database.util.DasUtil
import org.hamcrest.core.IsEqual

import java.io.*
/*
 * Available context bindings:
 *   SELECTION   Iterable<DasObject>
 *   PROJECT     project
 *   FILES       files helper
 */

packageName = "com.niyongsheng.persistence.domain;"
typeMapping = [
        (~/(?i)int/)                      : "Integer",
        (~/(?i)bit/)                      : "Boolean",
        (~/(?i)float|double|decimal|real/): "Double",
        (~/(?i)datetime|timestamp/)       : "java.util.Date",
        (~/(?i)date/)                     : "java.util.Date",
        (~/(?i)time/)                     : "java.util.Date",
        (~/(?i)/)                         : "String"
]

FILES.chooseDirectoryAndSave("Choose directory", "Choose where to store generated files") { dir ->
  SELECTION.filter { it instanceof DasTable }.each { generate(it, dir) }
}

def generate(table, dir) {
  def tableName = table.getName()
  // "_"分解表名成数组
  def array = tableName.tokenize('_')
  def className = javaName(tableName, array, true)
  def fields = calcFields(table, array)
  PrintWriter output = new PrintWriter(new OutputStreamWriter(new FileOutputStream( new File(dir, className + ".java")), "utf-8"))
  output.withPrintWriter { out -> generate(out, className, fields, tableName) }
}

def generate(out, className, fields, tableName) {
  out.println "package $packageName"
  out.println "import com.baomidou.mybatisplus.annotation.IdType;"
  out.println "import com.baomidou.mybatisplus.annotation.TableField;"
  out.println "import com.baomidou.mybatisplus.annotation.TableId;"
  out.println "import com.baomidou.mybatisplus.annotation.TableName;"
  out.println "import com.fasterxml.jackson.annotation.JsonFormat;"
  out.println "import io.swagger.annotations.ApiModel;"
  out.println "import io.swagger.annotations.ApiModelProperty;"
  out.println "import lombok.Data;"
  out.println "import org.springframework.format.annotation.DateTimeFormat;"
  out.println ""
  out.println "import java.io.Serializable;"
  out.println ""
  out.println "/**\n" +
          " * @author niyongsheng.com\n" +
          " * @version \$\n" +
          " * @des\n" +
          " * @updateAuthor \$\n" +
          " * @updateDes\n" +
          " */"
  out.println "@Data"
  out.println "@ApiModel(value =\"$className\")"
  out.println "@TableName(value = \"$tableName\")"
  out.println "public class $className implements Serializable {"
  fields.each() {
    if (isNotEmpty(it.commoent)) {
      out.println "\n  @ApiModelProperty(value = \"${it.commoent}\")"
      if (it.name == "id") {
        out.println "  @TableId(value = \"${it.name}\", type = IdType.AUTO)"
      } else {
        out.println "  @TableField(value = \"${it.name}\")"
      }
      if (it.type == "java.util.Date") {
        out.println "  @JsonFormat(pattern = \"yyyy-MM-dd HH:mm:ss\")"
        out.println "  @DateTimeFormat(pattern = \"yyyy-MM-dd HH:mm:ss\")"
      }
    }
    if (it.annos != "") out.println "  ${it.annos}"
    out.println "  private ${it.type} ${it.name};"
  }
  // setter getter Method
/*  out.println ""
  fields.each() {
    out.println ""
    out.println "  public ${it.type} get${it.name.capitalize()}() {"
    out.println "    return ${it.name};"
    out.println "  }"
    out.println ""
    out.println "  public void set${it.name.capitalize()}(${it.type} ${it.name}) {"
    out.println "    this.${it.name} = ${it.name};"
    out.println "  }"
    out.println ""
  }*/
  out.println "}"
}

def calcFields(table, array) {
  DasUtil.getColumns(table).reduce([]) { fields, col ->
    def spec = Case.LOWER.apply(col.getDataType().getSpecification())
    def typeStr = typeMapping.find { p, t -> p.matcher(spec).find() }.value
    fields += [[
                       name : javaName(col.getName(), false),
                       type : typeStr,
                       commoent: col.getComment(),
                       annos: ""]]
  }
}

def javaName(str, array, capitalize) {
  def s = com.intellij.psi.codeStyle.NameUtil.splitNameIntoWords(str)
          .collect { Case.LOWER.apply(it).capitalize() }
          .join("")
          .replaceAll(/[^\p{javaJavaIdentifierPart}[_]]/, "_")
  // 去除表名前缀  http://developer.51cto.com/art/200906/129168.htm
  s = s[array.size()+1..s.size()-1]
  capitalize || s.length() == 1? s : Case.LOWER.apply(s[0]) + s[1..-1]
}
def javaName(str,capitalize) {
  def s = com.intellij.psi.codeStyle.NameUtil.splitNameIntoWords(str)
          .collect { Case.LOWER.apply(it).capitalize() }
          .join("")
          .replaceAll(/[^\p{javaJavaIdentifierPart}[_]]/, "_")
  capitalize || s.length() == 1? s : Case.LOWER.apply(s[0]) + s[1..-1]
}
def isNotEmpty(content) {
  return content != null && content.toString().trim().length() > 0
}