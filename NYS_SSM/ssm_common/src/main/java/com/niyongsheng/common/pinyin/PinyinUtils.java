package com.niyongsheng.common.pinyin;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

public class PinyinUtils {

	/**
	 * 将字符串中的中文转化为拼音,英文字符不变
	 *
	 * @param inputString 汉字
	 * @return 转化后的字符串
	 */
	public String getPingYin(String inputString) {
		HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
		format.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		format.setVCharType(HanyuPinyinVCharType.WITH_V);
		StringBuilder output = new StringBuilder();
		if (inputString != null && inputString.length() > 0 && !"null".equals(inputString)) {
			char[] input = inputString.trim().toCharArray();
			try {
				for (char anInput : input) {
					if (Character.toString(anInput).matches("[\\u4E00-\\u9FA5]+")) {
						String[] temp = PinyinHelper.toHanyuPinyinStringArray(anInput, format);
						output.append(temp[0]);
					} else
						output.append(Character.toString(anInput));
				}
			} catch (BadHanyuPinyinOutputFormatCombination e) {
				e.printStackTrace();
			}
		} else {
			return "*";
		}
		return output.toString();
	}

	/**
	 * 汉字转换位汉语拼音首字母，英文字符不变
	 *
	 * @param chines 汉字
	 * @return 拼音
	 */
	public String converterToFirstSpell(String chines) {
		StringBuilder pinyinName = new StringBuilder();
		char[] nameChar = chines.toCharArray();
		HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
		defaultFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);
		defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		for (char aNameChar : nameChar) {
			if (aNameChar > 128) {
				try {
					pinyinName.append(PinyinHelper.toHanyuPinyinStringArray(aNameChar, defaultFormat)[0].charAt(0));
				} catch (BadHanyuPinyinOutputFormatCombination e) {
					e.printStackTrace();
				}
			} else {
				pinyinName.append(aNameChar);
			}
		}
		return pinyinName.toString();
	}
}
