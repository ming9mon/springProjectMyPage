package com.ming9.myPage.kakao.Service.Impl;

import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ming9.myPage.kakao.Service.KakaoMapService;
@Service
public class KakaoMapServiceImpl implements KakaoMapService{

	@Autowired
	Properties properties;

	public JSONObject getCCTVData(String minX, String maxX, String minY, String maxY) {
		JSONObject rst = new JSONObject();
		JSONArray rstArr = new JSONArray();
		int rtnCd = 0;
		String rtnRsn;
		
		String apiUrl = "http://openapi.its.go.kr:8081/api/NCCTVInfo";
		//String key = "1572567661466";
		String key = properties.getProperty("cctvKey");
		String ReqType = "2";
		
		String MinX=minX;
		String MaxX=maxX;
		String MinY=minY;
		String MaxY=maxY;
		
		String[] type=new String[]{"ex","its"};
		String cctvType="1";
		
		try{
			for(int z=0;z<type.length;z++){
				String urlStr = "http://openapi.its.go.kr:8081/api/NCCTVInfo";
				StringBuilder urlBuilder = new StringBuilder(apiUrl);
				urlBuilder.append("?" + URLEncoder.encode("key","UTF-8") + "=" +URLEncoder.encode(key, "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("ReqType","UTF-8") + "=" +URLEncoder.encode(ReqType, "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("MinX","UTF-8") + "=" +URLEncoder.encode(MinX, "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("MaxX","UTF-8") + "=" +URLEncoder.encode(MaxX, "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("MinY","UTF-8") + "=" +URLEncoder.encode(MinY, "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("MaxY","UTF-8") + "=" +URLEncoder.encode(MaxY, "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode(type[z], "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("CctvType","UTF-8") + "=" +URLEncoder.encode(cctvType, "UTF-8"));
				
				URL url = new URL(urlBuilder.toString());
				
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				org.w3c.dom.Document doc = dBuilder.parse(url.toString());
				doc.getDocumentElement().normalize();
	
				//NodeList list1 = doc.getElementsByTagName("cctvname");
				NodeList data = doc.getElementsByTagName("data");
				NodeList list2 = doc.getElementsByTagName("cctvurl");
				NodeList list3 = doc.getElementsByTagName("coordy");
				NodeList list4 = doc.getElementsByTagName("coordx");
				
				for(int i=0;i<data.getLength();i++) {
					Node node1 = data.item(i);
					
					if(node1.getNodeType() == Node.ELEMENT_NODE){ // 해당 노드의 종류 판정(Element일 때)
						
						JSONObject jsonVal = new JSONObject();
						Element e1 = (Element) node1;
						NodeList dataList = e1.getChildNodes();
						
						for(int j=0;j<dataList.getLength();j++) {
							Node dataNode = dataList.item(j);
							if(dataNode.getNodeType() == Node.ELEMENT_NODE){ 
								Element dataEl = (Element) dataNode;
								String nodeName = dataEl.getNodeName();
								String nodeData = dataEl.getTextContent();
								
								jsonVal.put(nodeName, nodeData);
							}
						}
						rstArr.add(jsonVal);
					}
				}
			}
			rst.put("RST", rstArr);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());

			rtnCd=-1;
			rtnRsn="fail";
			rst.put("RST", rtnRsn);
		}
		
		rst.put("RTNCD", rtnCd);
		
		return rst;
	}

}
