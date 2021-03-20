package com.wipro.banking.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import com.wipro.banking.bean.ManagerBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.util.BankingUtil;

public class ManagerDAO extends HttpServlet {

	public int authorized(ManagerBean bean) {
		ManagerBean result = new ManagerBean();
		;
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select user_id from manager where user_id=? and password=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, bean.getUserID());
			statement.setString(2, bean.getPassword());
			ResultSet resultset = statement.executeQuery();
			if (resultset.next())
				result.setUserID(resultset.getInt("user_id"));
			resultset.close();
			connection.close();
		} catch (Exception e) {
			return result.getUserID();
		}
		return result.getUserID();

	}

	public List<Map<String,Object>> requests(String ifscCode,String status) {
		List<Map<String,Object>> resultData = null;
		try {
			Map<String,Object> dataMap = new HashMap<String,Object>();
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select r.USERID,r.REQUESTDATE,r.REQUESTID,ca.ACCOUNTNUM,ca.BALANCE,ca.DATEOPENED from REQUESTS r,CUSTOMERACCOUNT ca where ca.USER_ID=r.USERID and ca.IFSCCODE=? and r.STATUS=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, ifscCode);
			statement.setString(2, status);
			ResultSet resultset = statement.executeQuery();
			resultData = new ArrayList<Map<String,Object>>();
			while (resultset.next()) {
				dataMap.put("USERID", resultset.getInt(1));
				dataMap.put("REQUESTDATE", resultset.getDate(2));
				dataMap.put("REQUESTID", resultset.getInt(3));
				dataMap.put("ACCOUNTNUM", resultset.getLong(4));
				dataMap.put("BALANCE", resultset.getDouble(5));
				dataMap.put("DATEOPENED", resultset.getDate(6));
				resultData.add(dataMap);
				dataMap = new HashMap<String,Object>();
			}
		} catch (Exception e) {
			return resultData;
		}
		return resultData;
	}

	public String getifsc(int id) {
		String result = null;
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select ifsccode from branch where manageruserid=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, id);
			ResultSet resultset = statement.executeQuery();
			//boolean d = resultset.next();
			if(resultset.next()) {
				result = resultset.getString("ifscCode");
			}
		} catch (Exception e) {
			
		}

		return result;
	}
	public int updateRequestStatus(int reqID,int rejAppr) {
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "update REQUESTS set STATUS=? where REQUESTID=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(2, reqID);
			if(rejAppr == 1) 
				statement.setString(1, "approved");
			else
				statement.setString(1, "rejected");
			return statement.executeUpdate();
			
		} catch (Exception e) {
			return -1;
		}
	} 
	public UserDetails findManager(int userID) {
		UserDetails result = new UserDetails();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from UserDetails where user_id=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, userID);
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				result.setUserID(rs.getInt("user_id"));
				result.setName(rs.getString("name"));
				result.setMobile_No(rs.getString("mobile_no"));
				result.setGender(rs.getString("gender"));
				result.setMailID(rs.getString("mail_id"));
				result.setStreetAdd(rs.getString("street_add"));
				result.setCity(rs.getString("city"));
				result.setAadhaar(rs.getString("aadhar"));
				result.setState(rs.getString("state"));
				result.setPAN(rs.getString("PAN"));

				return result;
			}
		} catch (Exception e) {
			return result;
		}
		return result;
	}
	// Update MAnager Detail
		public int updateManager(UserDetails ubean) {
			int resultCount = 0;
			try {
				Connection connection = BankingUtil.getDBConnection();
				String sql = "update USERDETAILS set MAIL_ID=? , MOBILE_NO=? , STREET_ADD = ? , CITY = ? , STATE = ? where USER_ID = ?";
				PreparedStatement statement = connection.prepareStatement(sql);
				statement.setInt(6, ubean.getUserID());
				statement.setString(1, ubean.getMailID());
				statement.setString(2, ubean.getMobile_No());
				statement.setString(3, ubean.getStreetAdd());
				statement.setString(4, ubean.getCity());
				statement.setString(5, ubean.getState());
				resultCount = statement.executeUpdate();
			} catch (Exception e) {
				return resultCount;
			}
			return resultCount;
		}

}
