package com.niyongsheng.common.utils;

import java.lang.management.ManagementFactory;
import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 *	网络相关的处理类 
 */
public class NetworkUtils {
	
	private static final String DEFAULT_HOST_NAME = "UDATA";
	private static final String DEFAULT_HOST_IP = "10.10.10.10";
	
	/**
	 *	获取当前进程的PID 
	 */
	public static String getPid(){
		return ManagementFactory.getRuntimeMXBean().getName().split("@")[0];
	}
	
	/**
	 *	获取当前进程的主机名称
	 */
	public static String getHostName(){
		try {
			return InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			return DEFAULT_HOST_NAME;
		}
	}
	
	/**
	 *	获取当前进程的主机IP地址
	 */
	public static String getHostIP(){
		try {
			return InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			return DEFAULT_HOST_IP;
		}
	}
	
	/**
	 *	获取当前进行的主机IP地址+进程PID,可自定义分隔符 
	 */
	public static String getIPAndPid(String sepc){
		return getHostIP()+sepc+getPid();
	}
	
}
