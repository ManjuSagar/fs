package com.fasternotes;

import java.io.*;
import java.util.*;
import java.io.FileInputStream;
import java.security.KeyStore;

import javax.net.ssl.SSLContext;
import javax.net.ssl.*;
import java.security.cert.*;
import java.security.SecureRandom;
import java.net.Socket;

import org.apache.http.HttpEntity;
import org.apache.http.entity.*;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.*;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.http.conn.ssl.*;
import org.apache.http.message.*;

public class MedicareEligibilityServiceList {
	String keyStoreFile;
	String keyStoreCertificatePwd;
	String[] requestDetails;
	String aliasName;

  public static void main(String args[]) {
	System.out.println("Main......Start");

	String host = "portal.visionshareinc.com:443";
	String url = "https://portal.visionshareinc.com/portal/seapi/services";
	String userAgent = "Jim's Practice Management System/2.3";
	String contentType = "application/text";
	String seapiVersion = "1";
	String myList [] = {url, seapiVersion, host, userAgent, contentType, ""};
	String aliasName = "cn=larry.treystman@001";
	String pwd = "b&3g9z$j";
	String keyStoreFile = "/home/msuser1/ability_keystore.jks";
	
	MedicareEligibilityServiceList mesl = new MedicareEligibilityServiceList(keyStoreFile, pwd, myList, aliasName);
	try {
		System.out.println(mesl.getMedicareEligibility271Response());
	} 
	catch (Exception ex) {
		System.out.println(ex);
	}
	System.out.println("Main......End");
  }
	
  public MedicareEligibilityServiceList(String keyStoreFile, String keyStoreCertificatePwd,
											String[] requestDetails, String aliasName )
  {
		this.keyStoreFile = keyStoreFile;
		this.keyStoreCertificatePwd = keyStoreCertificatePwd;
		this.requestDetails = requestDetails;
	    this.aliasName = aliasName;
  }
  
  public String getKeyStoreFile(){
		return keyStoreFile; 
	}
  
  public String getKeyStoreCertificatePwd(){
		return keyStoreCertificatePwd; 
	}

	public String getAliasName(){
		return aliasName;
	}

  static String convertStreamToString(java.io.InputStream is) {
			java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\A");
			return s.hasNext() ? s.next() : "";
  }
	
  public KeyStore getKeyStore() throws Exception {
		KeyStore keyStore  = KeyStore.getInstance("JKS");
		FileInputStream instream = new FileInputStream(new File(getKeyStoreFile()));
		try {
				keyStore.load(instream, "123456".toCharArray());
		} finally {
				instream.close();
		}
		return keyStore;
	}
	
	public SSLContext getSSLContext(KeyStore keyStore) throws Exception {
			return SSLContexts.custom()
				.loadKeyMaterial( keyStore, getKeyStoreCertificatePwd().toCharArray(), new PrivateKeyStrategy(){
				   public String chooseAlias(
                     final Map<String, PrivateKeyDetails> aliases, final Socket socket) {
                     return aliasName;
                   }
				})
				.loadTrustMaterial(null, new TrustStrategy() {

        public boolean isTrusted(
                final X509Certificate[] chain, String authType) throws CertificateException{
            return true;
        }

    }).build();
	}
	
	public SSLConnectionSocketFactory getSSLFactory(SSLContext sslContext) throws Exception {
	  return new SSLConnectionSocketFactory(sslContext);
  }
  	
	public CloseableHttpClient getHttpClient(SSLConnectionSocketFactory sslsf) throws Exception {
	  return HttpClients.custom().setSSLSocketFactory(sslsf).build();
  }
  
  public HttpGet getHttpGetRequest() throws Exception {
		HttpGet httpGet = new HttpGet(requestDetails[0]);
		BasicHeader seapiHeader = new BasicHeader("X-SEAPI-Version", requestDetails[1]);
		httpGet.addHeader(seapiHeader);           
		httpGet.setHeader("Host", requestDetails[2]);
		httpGet.setHeader("User-Agent", requestDetails[3]);
		httpGet.setHeader("Content-Type", requestDetails[4]);
				
		//HttpEntity entity = new ByteArrayEntity(requestDetails[5].getBytes("UTF-8"));
		//httpGet.setEntity(entity);
		return httpGet;
	}
	
	public String getMedicareEligibility271Response() throws Exception {
		KeyStore keyStore = getKeyStore();
		SSLContext sslContext = getSSLContext(keyStore);
		SSLConnectionSocketFactory sslsf = getSSLFactory(sslContext);		
		CloseableHttpClient httpClient = getHttpClient(sslsf); 
		try {
			HttpGet httpGet = getHttpGetRequest();	
			CloseableHttpResponse response = httpClient.execute(httpGet);
			try {
				HttpEntity responseEntity = response.getEntity();								
				return convertStreamToString(responseEntity.getContent());				
			} finally {
				response.close();
			}
        } finally {
            httpClient.close();
        }
	}  
}

