package com.wipro.banking.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.wipro.banking.bean.BeneficaryDetailBean;
import com.wipro.banking.bean.CustomerAccountBean;
import com.wipro.banking.bean.DebitCardBean;
import com.wipro.banking.bean.RequestsBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.bean.statementBean;
import com.wipro.banking.util.BankingUtil;

public class CustomerDAO {

	public CustomerAccountBean authorized(CustomerAccountBean bean) {
		CustomerAccountBean result = new CustomerAccountBean();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from customeraccount where customizedusername=? and profilepassword=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, bean.getCustomize_User_name());
			statement.setString(2, bean.getProfile_password());
			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {
				result.setUser_ID(resultset.getInt(1));
				result.setAccount_Num(resultset.getLong(2));
				result.setCustomize_User_name(resultset.getString(3));
			}
			resultset.close();
			connection.close();
		} catch (Exception e) {
			return result;
		}
		return result;
	}

	public List<statementBean> statement(String acc_num) {
		List<statementBean> result = null;
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from transactions where debitfrom=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, acc_num);
			ResultSet rs = statement.executeQuery();
			result = new ArrayList<statementBean>();
			while (rs.next()) {
				statementBean bean = new statementBean();
				bean.setTransactionID(rs.getInt(1));
				bean.setChronicle(rs.getString(2));
				bean.setTransactionMode(rs.getString(3));
				bean.setDebit(rs.getInt(6));
				result.add(bean);
			}
			sql = "select * from transactions where creditto=?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, acc_num);
			rs = statement.executeQuery();
			while (rs.next()) {
				statementBean bean = new statementBean();
				bean.setTransactionID(rs.getInt(1));
				bean.setChronicle(rs.getString(2));
				bean.setTransactionMode(rs.getString(3));
				bean.setCredit(rs.getInt(6));
				result.add(bean);
			}
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
		return result;
	}

	public RequestsBean status(int rid) {
		RequestsBean result = new RequestsBean();
		try {

			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from requests where requestid =?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, rid);

			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {
				result.setStatus(resultset.getString("status"));
				result.setUserid(resultset.getInt("userid"));
			}
			resultset.close();
			connection.close();
		} catch (Exception e) {
			return result;
		}
		return result;

	}

	public int addBeneficiary(BeneficaryDetailBean bean) {
		int result = 0;
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select BENEFICIARYACCOUNTNUM from beneficiarydetail where user_id=? and BENEFICIARYACCOUNTNUM=? and ifsccode=? ";
			PreparedStatement stat = connection.prepareStatement(sql);
			stat.setInt(1, Integer.parseInt(bean.getUser_ID()));
			stat.setInt(2, bean.getBeneficiary_Account());
			stat.setString(3, bean.getIFSC_Code());
			ResultSet rs = null;
			rs = stat.executeQuery();
			sql = "select ifsccode from customeraccount where ifsccode=? and ACCOUNTNUM=?";
			PreparedStatement state = connection.prepareStatement(sql);
			state.setString(1, bean.getIFSC_Code());
			state.setInt(2, bean.getBeneficiary_Account());
			ResultSet rss = state.executeQuery();
			if (rs.next()) {
				return -1;
			} else if (!rss.next()) {
				return 2;
			} else {
				String sql1 = "insert into beneficiarydetail values(?,?,?,?)";
				PreparedStatement statement = connection.prepareStatement(sql1);
				statement.setInt(1, Integer.parseInt(bean.getUser_ID()));
				statement.setInt(2, bean.getBeneficiary_Account());
				statement.setString(3, bean.getBeneficiary_name());
				statement.setString(4, bean.getIFSC_Code());
				result = statement.executeUpdate();
			}
		} catch (Exception e) {
			System.out.print("exception");
		}
		return result;
	}

	public int otherBeneficiary(BeneficaryDetailBean bean) {
		int result = 0;
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select BENEFICIARYACCOUNTNUM from beneficiarydetail where user_id=? and BENEFICIARYACCOUNTNUM=? and ifsccode=? ";
			PreparedStatement stat = connection.prepareStatement(sql);
			stat.setInt(1, Integer.parseInt(bean.getUser_ID()));
			stat.setInt(2, bean.getBeneficiary_Account());
			stat.setString(3, bean.getIFSC_Code());
			ResultSet rs = null;
			rs = stat.executeQuery();
			sql = "select ifsccode from customeraccount where ifsccode=? and ACCOUNTNUM=?";
			PreparedStatement state = connection.prepareStatement(sql);
			state.setString(1, bean.getIFSC_Code());
			state.setInt(2, bean.getBeneficiary_Account());
			ResultSet rss = state.executeQuery();
			if (rss.next()) {
				result = 4;
			} else if (rs.next()) {
				return -1;
			} else {
				String sql1 = "insert into beneficiarydetail values(?,?,?,?)";
				PreparedStatement statement = connection.prepareStatement(sql1);
				statement.setInt(1, Integer.parseInt(bean.getUser_ID()));
				statement.setInt(2, bean.getBeneficiary_Account());
				statement.setString(3, bean.getBeneficiary_name());
				statement.setString(4, bean.getIFSC_Code());
				result = statement.executeUpdate();
			}
		} catch (Exception e) {
			System.out.print("exception");
		}
		return result;
	}

	public List<BeneficaryDetailBean> getBeneficiary(String id, String call) {
		List<BeneficaryDetailBean> list = new ArrayList<BeneficaryDetailBean>();
		try {
			String sql = null;
			Connection connection = BankingUtil.getDBConnection();
			if (call.equals("within"))
				sql = "select * from beneficiarydetail where user_id=? and BENEFICIARYBANK='withinbank' ";
			else if (call.equals("other"))
				sql = "select * from beneficiarydetail where user_id=? and BENEFICIARYBANK='otherbank' ";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, Integer.parseInt(id));
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				BeneficaryDetailBean bean = new BeneficaryDetailBean();
				bean.setUser_ID(Integer.toString(rs.getInt(1)));
				bean.setBeneficiary_Account(rs.getInt(2));
				bean.setBeneficiary_name(rs.getString(3));
				bean.setIFSC_Code(rs.getString(5));
				list.add(bean);
			}
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
		return list;
	}

	public List<BeneficaryDetailBean> getBeneficiaryother(String id) {
		List<BeneficaryDetailBean> list = new ArrayList<BeneficaryDetailBean>();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from beneficiarydetail where user_id=? and BENEFICIARYBANK='withinbank' ";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, Integer.parseInt(id));
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				BeneficaryDetailBean bean = new BeneficaryDetailBean();
				bean.setUser_ID(Integer.toString(rs.getInt(1)));
				bean.setBeneficiary_Account(rs.getInt(2));
				bean.setBeneficiary_name(rs.getString(3));
				bean.setIFSC_Code(rs.getString(5));
				list.add(bean);
			}
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
		return list;
	}

	public CustomerAccountBean getCustomerDetails(String id) {
		CustomerAccountBean bean = new CustomerAccountBean();
		try {
			Connection conncection = BankingUtil.getDBConnection();
			String sql = "select ACCOUNTNUM,name,IFSCCODE,BALANCE from userdetails ud,customeraccount ac where ud.user_id=? and ud.user_id=ac.user_id";
			PreparedStatement state = conncection.prepareStatement(sql);
			state.setInt(1, Integer.parseInt(id));
			ResultSet rs = state.executeQuery();
			if (rs.next()) {
				bean.setAccount_Num(rs.getInt(1));
				bean.setCustomize_User_name(rs.getString(2));
				bean.setIFSC_Code(rs.getString(3));
				bean.setBalance(rs.getLong(4));
			}
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
		return bean;
	}

	public int checkDebitwithin(String id, Long accNum, int amount, String password) {
		int result = 0, balance, account, transID = 0;
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select balance,ACCOUNTNUM from customeraccount where user_id=? and TRANSACTIONPASSWORD=?";
			PreparedStatement state = connection.prepareStatement(sql);
			state.setInt(1, Integer.parseInt(id));
			state.setString(2, password);
			ResultSet rs = state.executeQuery();
			if (!rs.next()) {
				return 4;
			} else {
				balance = rs.getInt(1);
				if (balance < amount)
					return 2;
				account = rs.getInt(2);
				balance = balance - amount;
				sql = "update customeraccount set balance=? where user_ID=?";
				PreparedStatement stat = connection.prepareStatement(sql);
				stat.setInt(1, balance);
				stat.setInt(2, Integer.parseInt(id));
				result = stat.executeUpdate();
				if (result == 0) {
					return 3;
				} else {
					sql = "select balance from customeraccount where accountnum=?";
					stat = connection.prepareStatement(sql);
					stat.setLong(1, accNum);
					ResultSet rss = stat.executeQuery();
					if (!rss.next()) {
						return 3;
					} else {
						balance = rss.getInt(1);

						balance = balance + amount;
						sql = "update customeraccount set balance=? where accountnum=?";
						stat = connection.prepareStatement(sql);
						stat.setInt(1, balance);
						stat.setLong(2, accNum);
						result = 0;
						result = stat.executeUpdate();
						if (result == 0) {
							return 3;
						}
					}
				}
				sql = "insert into transactions values (trans_sequence.nextval, CURRENT_DATE, 'within',?, ?, ?, 'success','For Laxmi Chit Fund', 'Customer is Cool' )";
				stat = connection.prepareStatement(sql);
				stat.setInt(1, account);
				stat.setLong(2, accNum);
				stat.setInt(3, amount);
				stat.executeUpdate();
				sql = "select trans_sequence.currval from dual";
				stat = connection.prepareStatement(sql);
				rs = stat.executeQuery();
				if (rs.next()) {
					transID = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
		return transID;
	}

	public int checkDebitother(String id, Long accNum, int amount, String mode, String tpassword) {
		int result = 0, balance, account, transID = 0;
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select balance,ACCOUNTNUM from customeraccount where user_id=? and TRANSACTIONPASSWORD=?";
			PreparedStatement stat = connection.prepareStatement(sql);
			stat.setInt(1, Integer.parseInt(id));
			stat.setString(2, tpassword);
			ResultSet rs = stat.executeQuery();
			if (!rs.next()) {
				return 4;
			} else {
				balance = rs.getInt(1);
				if (balance < amount)
					return 2;
				account = rs.getInt(2);
				balance = balance - amount;
				sql = "update customeraccount set balance=? where user_ID=?";
				stat = connection.prepareStatement(sql);
				stat.setInt(1, balance);
				stat.setInt(2, Integer.parseInt(id));
				result = stat.executeUpdate();
				if (result == 0)
					return 3;
			}
			sql = "insert into transactions values (trans_sequence.nextval, CURRENT_DATE, ?,?, ?, ?, 'success','For Laxmi Chit Fund', 'Customer is Cool' )";
			stat = connection.prepareStatement(sql);
			stat.setString(1, mode);
			stat.setInt(2, account);
			stat.setLong(3, accNum);
			stat.setInt(4, amount);
			stat.executeUpdate();
			sql = "select trans_sequence.currval from dual";
			stat = connection.prepareStatement(sql);
			rs = stat.executeQuery();
			if (rs.next()) {
				transID = rs.getInt(1);
			}

		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
		return transID;
	}

	public CustomerAccountBean fetchInternetBanking(int userid) {
		CustomerAccountBean result = new CustomerAccountBean();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from customeraccount where user_id=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, userid);

			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {

				result.setInternet_bank_status(resultset.getString("internetbankingstatus"));
				result.setAccount_Num(resultset.getLong("accountnum"));
			}
			resultset.close();
			connection.close();
		} catch (Exception e) {
			return result;
		}
		return result;
	}

	public DebitCardBean fetchDebitCardDetails(long account_Num) {
		DebitCardBean debitCardBean = new DebitCardBean();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from debitcard where accountnum=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, account_Num);

			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {

				debitCardBean.setPin(resultset.getInt("pin"));
				debitCardBean.setCard_No(resultset.getLong("cardno"));
			}
			resultset.close();
			connection.close();
		} catch (Exception e) {
			return debitCardBean;
		}

		return debitCardBean;
	}

	public RequestsBean CustomerAcc(int accno) {
		RequestsBean bean = new RequestsBean();
		CustomerAccountBean customeraccount = new CustomerAccountBean();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from CustomerAccount where accountNum =?";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setInt(1, accno);
			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {
				customeraccount.setUser_ID(resultset.getInt("USER_ID"));
				customeraccount.setIFSC_Code(resultset.getString("ifscCode"));

			}

			String sql1 = "select requestid from Requests where userid =?";
			PreparedStatement statement1 = connection.prepareStatement(sql1);
			statement1.setInt(1, customeraccount.getUser_ID());
			ResultSet resultset1 = statement1.executeQuery();

			if (resultset1.next()) {
				bean.setRequestid(resultset1.getInt("requestid"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	public RequestsBean RequestId(int accno) {
		CustomerAccountBean customeraccount = new CustomerAccountBean();
		RequestsBean bean = new RequestsBean();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from CustomerAccount where accountNum =?";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setInt(1, accno);
			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {
				customeraccount.setUser_ID(resultset.getInt("USER_ID"));
				customeraccount.setIFSC_Code(resultset.getString("ifscCode"));
			}

			String sql2 = "INSERT INTO Requests(userid,ifscCode,status,requestId,requestdate,remarks) VALUES (?,?,?,request_sequence.nextval,TO_DATE(TO_CHAR(CURRENT_DATE, 'DD-MM-YYYY'), 'DD/MM/YYYY'),?)";

			String s = "pending";
			String r = "no remarks";

			PreparedStatement statement1 = connection.prepareStatement(sql2);
			statement1.setInt(1, customeraccount.getUser_ID());
			statement1.setString(2, customeraccount.getIFSC_Code());
			statement1.setString(3, s);
			statement1.setString(4, r);

			bean.setUserid(customeraccount.getUser_ID());
			bean.setIfsccode(customeraccount.getIFSC_Code());
			ResultSet resultset3 = statement1.executeQuery();
			if (resultset3.next()) {
				int a = 10;
			}

			String sql3 = "select requestId from Requests where userId  =?";
			PreparedStatement statement2 = connection.prepareStatement(sql3);
			statement2.setInt(1, bean.getUserid());
			ResultSet resultset1 = statement2.executeQuery();

			if (resultset1.next()) {
				bean.setRequestid(resultset1.getInt("requestId"));

			}
		}

		catch (Exception e) {
			e.printStackTrace();
			;
		}
		return bean;

	}

	public int updateCustomerDetails(String uname, String password, int userid, String tpassword) {

		int result = 0;
		try {

			Connection connection = BankingUtil.getDBConnection();
			String sql = "UPDATE customeraccount SET customizedusername =? ,profilepassword =?,transactionpassword=? WHERE user_id=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, uname);
			statement.setString(2, password);
			statement.setString(3, tpassword);
			statement.setInt(4, userid);
			result = statement.executeUpdate();
			if (result != 0)
				return 1;
		} catch (Exception e) {

		}
		return result;

	}

	public DebitCardBean validate(int accno) {
		DebitCardBean result = new DebitCardBean();
		try {
			Connection connection = BankingUtil.getDBConnection();
			String sql = "select * from DebitCard where accountNum =?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, accno);
			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {
				result.setCard_No(resultset.getLong("cardno"));
				result.setPin(resultset.getInt("pin"));
				resultset.close();
				connection.close();
			}

		} catch (Exception e) {
			return result;

		}
		return result;
	}

	// Manager My Data
	public UserDetails findCustomer(int userID) {
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
	public int updateCustomer(UserDetails ubean) {
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
