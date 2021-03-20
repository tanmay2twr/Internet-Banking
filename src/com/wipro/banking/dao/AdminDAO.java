package com.wipro.banking.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.wipro.banking.bean.AdminBean;
import com.wipro.banking.bean.ManagerBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.util.BankingUtil;



public class AdminDAO extends HttpServlet {
	

	
//Admin Login
	public int authorized(AdminBean bean) {
		AdminBean result = new AdminBean();;
		try {
        	Connection connection = BankingUtil.getDBConnection();
        	String sql = "select user_id from Admin where user_id=? and password=?";
        	PreparedStatement statement = connection.prepareStatement(sql);
        	statement.setInt(1, bean.getUser_ID());
        	statement.setString(2, bean.getPassword());
        	ResultSet resultset = statement.executeQuery();
        	if(resultset.next())
            	result.setUser_ID(resultset.getInt("user_id"));
        	resultset.close();
        	connection.close();
        }
        catch(Exception e) {
        	return result.getUser_ID();
        }
		return result.getUser_ID();
	}

//Admin My Data
	public UserDetails findAdmin(int userID) {
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
	// Update Admin Detail
		public int updateAdmin(UserDetails ubean) {
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

//Add Manager
	public int addManager(ManagerBean bean , UserDetails mbean)
	{
		int result=0;
		try {
			if(insertUserDetail(mbean) !=0)
				result = insertManager(bean);
        }
        catch(Exception e) {
        	return result;
        }
		return result;
	}
	private int insertManager(ManagerBean bean) throws SQLException{
		int result=0;
        Connection connection = BankingUtil.getDBConnection();
        String sql = "INSERT INTO Manager(USER_ID,PASSWORD) VALUES (user_id.nextval-1,?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, bean.getPassword());
        result = statement.executeUpdate();
        connection.close();
		return result;
	}
	
	private int insertUserDetail(UserDetails bean) throws SQLException {
		long val = Long.parseLong(bean.getMobile_No());
		Connection connection = BankingUtil.getDBConnection();
    	String sql = "INSERT INTO UserDetails (NAME, MOBILE_NO, GENDER,MAIL_ID,STREET_ADD,CITY,STATE,AADHAAR,PAN,USER_ID) VALUES (?,?,?,?,?,?,?,?,?,user_id.nextval)";
    	PreparedStatement statement = connection.prepareStatement(sql);
    	statement.setString(1, bean.getName());
    	statement.setString(2, bean.getMobile_No());
    	statement.setString(3, bean.getGender());
    	statement.setString(4, bean.getMailID());
    	statement.setString(5, bean.getStreetAdd());
    	statement.setString(6, bean.getCity());
    	statement.setString(7, bean.getState());
    	statement.setString(8, bean.getAadhaar());
    	statement.setString(9, bean.getPAN());
    	return statement.executeUpdate();
	}
//Delete Manager
	public int deleteManager(int user_id){
		int result=0;
		
		try {
		
        Connection connection = BankingUtil.getDBConnection();
        String sql = "DELETE from Manager where user_id=?";
        String sql2 = "DELETE from userdetails where user_id=?";
        PreparedStatement statement = connection.prepareStatement(sql);
        PreparedStatement statement1 = connection.prepareStatement(sql2);
        statement.setInt(1, user_id);
        statement1.setInt(1, user_id);
        result = statement.executeUpdate();
        result = statement1.executeUpdate();
        connection.close();
		
		}
		catch(Exception sqlException)
		{
			
		}
		return result;
	}
//Modify Manager
	public int modifyBankManager(UserDetails bean)  {
		long val = Long.parseLong(bean.getMobile_No());int result=0;
		try {
		Connection connection = BankingUtil.getDBConnection();
    	String sql = "UPDATE userdetails SET name =?,mobile_no =?,gender =?,mail_id =?,street_add =?,city =?,state =?,aadhaar =?,pan =? WHERE user_id=?";
    	PreparedStatement statement = connection.prepareStatement(sql);
    	statement.setString(1, bean.getName());
    	statement.setString(2, bean.getMobile_No());
    	statement.setString(3, bean.getGender());
    	statement.setString(4, bean.getMailID());
    	statement.setString(5, bean.getStreetAdd());
    	statement.setString(6, bean.getCity());
    	statement.setString(7, bean.getState());
    	statement.setString(8, bean.getAadhaar());
    	statement.setString(9, bean.getPAN());
    	statement.setInt(10, bean.getUserID());
    	result= statement.executeUpdate();
		}catch(Exception e) {
    	
		}
		return result;
		
	}
public Map<String, Object> managerBranchDetail() {
		Map<String, Object> mbdata = new HashMap<String, Object>();
		mbdata.put("BRANCH", managerBranch());
		mbdata.put("BRANCHMANAGER", managerDetail());
		return mbdata;
	}

	public int updateDelete(String modifyData, int status) {
		String sql = "";
		Connection connection = BankingUtil.getDBConnection();
		PreparedStatement statement;
		try {
			if (status == 1) {
				JSONParser parser = new JSONParser();
				JSONObject json = (JSONObject) parser.parse(modifyData);
				String ifscCode = (String) json.get("ifscCode");
				int userId = Integer.parseInt((String) json.get("userId"));
				sql = "select count(MANAGERUSERID) as Count from BRANCH where IFSCCODE= ?";
				statement = connection.prepareStatement(sql);
				statement.setString(1, ifscCode.toString());
				// statement.setString(1, "UTIB0003960");
				ResultSet rset = statement.executeQuery();
				if (rset.next() && rset.getInt("Count") == 0) {
					sql = "update BRANCH set MANAGERUSERID=NULL where MANAGERUSERID= ?";
					statement = connection.prepareStatement(sql);
					statement.setInt(1, userId);
					int rcount = statement.executeUpdate();
					if (rcount == 1) {
						sql = "update BRANCH set MANAGERUSERID=? where IFSCCODE= ?";
						statement = connection.prepareStatement(sql);
						statement.setInt(1, userId);
						statement.setString(2, ifscCode);
						rcount = statement.executeUpdate();
						if (rcount == 1)
							return 3;
						else
							return 2;
					} else
						return 1;
				} else
					return 0;
			} else {
				sql = "update BRANCH set MANAGERUSERID=NULL where MANAGERUSERID= ?";
				statement = connection.prepareStatement(sql);
				statement.setInt(1, Integer.parseInt(modifyData));
				int rcount = statement.executeUpdate();
				if (rcount == 1) {
					//
					sql = "delete from MANAGER where USER_ID=?";
					statement = connection.prepareStatement(sql);
					statement.setInt(1, Integer.parseInt(modifyData));
					rcount = statement.executeUpdate();
					if (rcount == 1) {
						sql = "delete from USERDETAILS where USER_ID=?";
						statement = connection.prepareStatement(sql);
						statement.setInt(1, Integer.parseInt(modifyData));
						rcount = statement.executeUpdate();
						if (rcount == 1)
							return 3;
						else
							return 2;
					} else
						return 1;
				} else
					return 0;
			}
		} catch (Exception e) {
			return -1;
		}
	}

	public int addManager(String managerDetail) {
		String sql = "";
		Connection connection = BankingUtil.getDBConnection();
		PreparedStatement statement;
		try {
			JSONParser parser = new JSONParser();
			JSONObject json = (JSONObject) parser.parse(managerDetail);
			String ifscCode = (String) json.get("IFSCCODE");
			sql = "select count(MANAGERUSERID) as Count from BRANCH where IFSCCODE= ?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, ifscCode.toString());
			ResultSet rset = statement.executeQuery();
			if (rset.next() && rset.getInt("Count") == 0) {
				String aadhar = (String) json.get("AADHAR");
				String pan = (String) json.get("PAN");
				String mobile_no = (String) json.get("MOBILE_NO");
				String paswd = aadhar.toUpperCase().substring(0, 4).concat(pan.toUpperCase().substring(0, 3))
						.concat(mobile_no.substring(0, 4));
				int managerID = insertManagerUserDetails(json);
				if (managerID != 0 && managerID != -1) {
					sql = "insert into MANAGER values(?,?)";
					statement = connection.prepareStatement(sql);
					statement.setInt(1, managerID);
					statement.setString(2, paswd);
					int rcount = statement.executeUpdate();
					if (rcount == 1) {
						String ifsccode = (String) json.get("IFSCCODE");
						sql = "update BRANCH set MANAGERUSERID=? where IFSCCODE=?";
						statement = connection.prepareStatement(sql);
						statement.setInt(1, managerID);
						statement.setString(2, ifsccode);
						rcount = statement.executeUpdate();
						if (rcount == 1)
							return managerID;
						else
							return 2;
					} else
						return 1;
				} else
					return 0;
			} else
				return -1;
		} catch (Exception e) {
			return 0;
		}
	}

	private int insertManagerUserDetails(JSONObject json) throws SQLException {
		String mname = (String) json.get("MANAGER_NAME");
		String aadhar = (String) json.get("AADHAR");
		String pan = (String) json.get("PAN");
		String mail_id = (String) json.get("MAIL_ID");
		String mobile_no = (String) json.get("MOBILE_NO");
		String gender = (String) json.get("GENDER");
		Connection connection = BankingUtil.getDBConnection();
		PreparedStatement statement;
		String sql = "insert into USERDETAILS(USER_ID,NAME,MOBILE_NO,GENDER,MAIL_ID,AADHAR,PAN) values(USER_ID.nextval,?,?,?,?,?,?)";
		statement = connection.prepareStatement(sql);
		statement.setString(1, mname);
		statement.setString(2, mobile_no);
		statement.setString(3, gender.toLowerCase());
		statement.setString(4, mail_id);
		statement.setString(5, aadhar);
		statement.setString(6, pan);
		int rcount = statement.executeUpdate();
		if (rcount == 1) {
			sql = "select USER_ID.currval val from dual";
			statement = connection.prepareStatement(sql);
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				return rs.getInt("val");
			} else
				return 0;
		} else
			return -1;
	}
	// Get List of IFSCCODE
		private ArrayList<Map<String, String>> managerBranch() {
			ArrayList<Map<String, String>> arrList = null;
			try {
				Map<String, String> branchData = new HashMap<String, String>();
				arrList = new ArrayList<Map<String, String>>();
				Connection connection = BankingUtil.getDBConnection();
				String sql = "select BRANCHNAME,IFSCCODE,CITY from BRANCH";
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet result = statement.executeQuery();
				while (result.next()) {
					branchData.put("BRANCHNAME", result.getString("BRANCHNAME"));
					branchData.put("IFSCCODE", result.getString("IFSCCODE"));
					branchData.put("CITY", result.getString("CITY"));
					arrList.add(branchData);
					branchData = new HashMap<String, String>();
				}

			} catch (Exception e) {
				return arrList;
			}
			return arrList;
		}

		private ArrayList<Map<String, Object>> managerDetail() {
			ArrayList<Map<String, Object>> arrList = null;
			try {
				arrList = new ArrayList<Map<String, Object>>();
				Map<String, Object> mdata = new HashMap<String, Object>();
				Connection connection = BankingUtil.getDBConnection();
				String sql = "select m.USER_ID,u.NAME,b.BRANCHNAME,b.IFSCCODE,b.CITY from Manager m,USERDETAILS u,BRANCH b where m.USER_ID=u.USER_ID and b.MANAGERUSERID=m.USER_ID ORDER BY m.USER_ID";
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet result = statement.executeQuery();
				while (result.next()) {
					mdata.put("USER_ID", result.getInt("USER_ID"));
					mdata.put("NAME", result.getString("NAME"));
					mdata.put("BRANCHNAME", result.getString("BRANCHNAME"));
					mdata.put("IFSCCODE", result.getString("IFSCCODE"));
					mdata.put("CITY", result.getString("CITY"));
					arrList.add(mdata);
					mdata = new HashMap<String, Object>();
				}

			} catch (Exception e) {
				return arrList;
			}
			return arrList;
		}

}
