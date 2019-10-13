package com.niyongsheng.application.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @author niyongsheng.com
 * @version $
 * @des 配置swagger2信息
 * @updateAuthor $
 * @updateDes
 */
@Configuration
@EnableWebMvc // 启用Mvc，非springboot框架需要引入
@EnableSwagger2
public class Swagger2Config {

    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                // 扫描指定包中的swagger注解
                .apis(RequestHandlerSelectors.basePackage("com.niyongsheng.application"))
                // 扫描所有有注解的api，用这种方式更灵活
//                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        Contact contact = new Contact("NiYongsheng","https://github.com/niyongsheng","niyongsheng@outlook.com");
        return new ApiInfoBuilder()
                .title("稻草堆项目-移动端 APIs")
                .description("Talk is cheap. Show me the code.")
                .termsOfServiceUrl("https://github.com/niyongsheng/NYS_SSM")
                .version("1.0.0")
                .contact(contact)
                .license("MIT")
                .licenseUrl("https://github.com/niyongsheng/NYS_SSM/blob/master/LICENSE")
                .build();
    }
}
