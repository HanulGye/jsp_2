package com.hanul.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.hanul.util.DBConnector;

public class NoticeDAO {
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
	public ArrayList<NoticeDTO> selectList() throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "SELECT * FROM notice ORDER BY reg_date DESC";
		PreparedStatement st = con.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		NoticeDTO nDto = null;
		ArrayList<NoticeDTO> ar = new ArrayList<>();
		while(rs.next()) {
			nDto = new NoticeDTO();
			nDto.setNo(rs.getInt(1));
			nDto.setSubject(rs.getString(2));
			nDto.setContent(rs.getString(3));
			nDto.setWriter(rs.getString(4));
			nDto.setReg_date(rs.getDate(5));
			nDto.setHit(rs.getInt(6));
			ar.add(nDto);
		}
		DBConnector.disConnect(rs, st, con);
		return ar;
	}
	
}
