package com.niyongsheng.common.ssq;

import org.apache.commons.codec.binary.Hex;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class Shuangseqiu {

    final static Integer[] numArray = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33};
    final static String[] strArray = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33"};
    static List<Integer[]> allSorts = new ArrayList<Integer[]>();

    public static void permutation(Integer[] nums, Integer start, Integer end) {
        if (start == end) { // 当只要求对数组中一个数字进行全排列时，只要就按该数组输出即可
            Integer[] newNums = new Integer[nums.length]; // 为新的排列创建一个数组容器
            for (Integer i = 0; i <= end; i++) {
                newNums[i] = nums[i];
            }
            allSorts.add(newNums); // 将新的排列组合存放起来
        } else {
            for (Integer i = start; i <= end; i++) {
                Integer temp = nums[start]; // 交换数组第一个元素与后续的元素
                nums[start] = nums[i];
                nums[i] = temp;
                permutation(nums, start + 1, end); // 后续元素递归全排列
                nums[i] = nums[start]; // 将交换后的数组还原
                nums[start] = temp;
            }
        }
    }

    public static void main(String[] args) {
        permutation(numArray, 0, numArray.length - 1);
        Integer[][] a = new Integer[allSorts.size()][]; // 你要的二维数组a
        allSorts.toArray(a);

        // 打印验证
        for (Integer i = 0; i < a.length; i++) {
            Integer[] nums = a[i];
            for (Integer j = 0; j < nums.length; j++) {
                System.out.print(nums[j]);
            }
            System.out.println();
        }
        System.out.println(a.length);
    }

    /**
     * sha256 加密
     */
    public static String sha256(String text) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(text.getBytes("UTF-8"));
            return new String(Hex.encodeHex(hash));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
