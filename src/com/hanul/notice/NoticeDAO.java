package com.hanul.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.hanul.util.DBConnector;

public class NoticeDAO {
	//getCount
	public int getCount(String kind, String search) throws Exception {
		Connection con = DBConnector.getConnect();
		String sql="select count(no) from notice "
				+ "where "+kind+" like ?";
		
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, "%"+search+"%");
		
		ResultSet rs = st.executeQuery();
		rs.next();
		int result=rs.getInt(1);
		
		DBConnector.disConnect(rs, st, con);
		
		return result;
		
	}
	
	//hitAdd
	public int hitAdd(int hit, int no) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "UPDATE notice SET hit=? WHERE no=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, hit);
		st.setInt(2, no);
		int result = st.executeUpdate();
		return result;
	}
	
	//delete
	public int delete(int no) throws Exception{
		
		Connection con = DBConnector.getConnect();
		String sql ="DELETE notice WHERE no = ?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, no);
	
		int result = st.executeUpdate();
		
		DBConnector.disConnect(st, con);
		
		return result;
	}
	
	
	//selectOne
	public NoticeDTO selectOne(int no) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "SELECT * FROM notice WHERE no = ?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, no);
		ResultSet rs = st.executeQuery();
		NoticeDTO nDto = null;
		
		if(rs.next()) {
			nDto = new NoticeDTO();
			nDto.setNo(rs.getInt(1));
			nDto.setSubject(rs.getString(2));
			nDto.setContent(rs.getString(3));
			nDto.setWriter(rs.getString(4));
			nDto.setReg_date(rs.getDate(5));
			nDto.setHit(rs.getInt(6));
		}
		DBConnector.disConnect(rs, st, con);
		return nDto;
		
	}
	
	//insert
	public int insert(NoticeDTO nDto) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "INSERT INTO notice VALUES(notice_seq.nextval, ?, ?, ?, sysdate, 0)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, nDto.getSubject());
		st.setString(2, nDto.getContent());
		st.setString(3, nDto.getWriter());
		
		int result = st.executeUpdate();
		
		DBConnector.disConnect(st, con);
		
		return result;
	}
	
	//selectList
	public ArrayList<NoticeDTO> selectList(int startRow, int lastRow, String kind, String search) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "SELECT * FROM "
				+ "(select rownum R, N.* from "
				+ "(select no, subject, writer, reg_date, hit from notice "
				+ "where "+kind+" like ? "
				+ "order by no desc) N) "
				+ "where R between ? and ?";
		PreparedStatement st = con.prepareStatement(sql);
		
		st.setString(1, "%"+search+"%");
		st.setInt(2, startRow);
		st.setInt(3, lastRow);
		
		ResultSet rs = st.executeQuery();
		NoticeDTO nDto = null;
		ArrayList<NoticeDTO> ar = new ArrayList<>();
		while(rs.next()) {
			nDto = new NoticeDTO();
			nDto.setNo(rs.getInt("no"));
			nDto.setSubject(rs.getString("subject"));
			nDto.setWriter(rs.getString("writer"));
			nDto.setReg_date(rs.getDate("reg_date"));
			nDto.setHit(rs.getInt("hit"));
			ar.add(nDto);
		}
		DBConnector.disConnect(rs, st, con);
		return ar;
	}
	
}
