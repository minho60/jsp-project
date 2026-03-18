package service.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import service.dto.FaqDTO;
import util.DBConnectionMgr;

public class FaqDAO {

    // FAQ 목록 조회 (카테고리 + 검색 + 페이징)
    public List<FaqDTO> getFaqList(String category, String keyword, int offset, int limit) {
        List<FaqDTO> list = new ArrayList<>();
        String sql = "SELECT qaNum, type, question, answer FROM faq WHERE 1=1";

        if(category != null && !category.isEmpty()) sql += " AND type = ?";
        if(keyword != null && !keyword.isEmpty()) sql += " AND question LIKE ?";
        sql += " ORDER BY qaNum DESC LIMIT ?, ?";

        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            if(category != null && !category.isEmpty()) ps.setString(idx++, category);
            if(keyword != null && !keyword.isEmpty()) ps.setString(idx++, "%" + keyword + "%");
            ps.setInt(idx++, offset);
            ps.setInt(idx++, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while(rs.next()) {
                    FaqDTO dto = new FaqDTO();
                    dto.setQaNum(rs.getInt("qaNum"));
                    dto.setType(rs.getString("type"));
                    dto.setQuestion(rs.getString("question"));
                    dto.setAnswer(rs.getString("answer"));
                    list.add(dto);
                }
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // FAQ 총 개수 (카테고리 + 검색 포함)
    public int getFaqCount(String category, String keyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM faq WHERE 1=1";
        if(category != null && !category.isEmpty()) sql += " AND type = ?";
        if(keyword != null && !keyword.isEmpty()) sql += " AND question LIKE ?";

        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            if(category != null && !category.isEmpty()) ps.setString(idx++, category);
            if(keyword != null && !keyword.isEmpty()) ps.setString(idx++, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                if(rs.next()) count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    // FAQ 상세 조회
    public FaqDTO getFaq(int qaNum) {

        FaqDTO faq = null;

        String sql = "SELECT qaNum, type, question, answer FROM faq WHERE qaNum = ?";

        try (
            Connection conn = DBConnectionMgr.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {

            pstmt.setInt(1, qaNum);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                faq = new FaqDTO();

                faq.setQaNum(rs.getInt("qaNum"));
                faq.setType(rs.getString("type"));
                faq.setQuestion(rs.getString("question"));
                faq.setAnswer(rs.getString("answer"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return faq;
    }
    
}