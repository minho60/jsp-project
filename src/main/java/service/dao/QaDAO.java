package service.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import service.dto.QaDTO;
import util.DBConnectionMgr;

public class QaDAO {

    // 글 등록 (회원/비회원 구분)
    public int insertQa(QaDTO dto) {
        String sql = "INSERT INTO qa(type, title, content, user_num, guest_name, guest_password, guest_email) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        int result = 0;

        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dto.getType());
            ps.setString(2, dto.getTitle());
            ps.setString(3, dto.getContent());

            if (dto.getUserNum() != null) {
                ps.setLong(4, dto.getUserNum());
                ps.setNull(5, Types.VARCHAR);
                ps.setNull(6, Types.VARCHAR);
                ps.setNull(7, Types.VARCHAR);
            } else {
                ps.setNull(4, Types.BIGINT);
                ps.setString(5, dto.getGuestName());

                if (dto.getGuestPassword() != null) {
                    String hashed = BCrypt.hashpw(dto.getGuestPassword(), BCrypt.gensalt());
                    ps.setString(6, hashed);
                } else {
                    ps.setNull(6, Types.VARCHAR);
                }

                ps.setString(7, dto.getGuestEmail());
            }

            result = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 글 단건 조회
    public QaDTO findById(long qaNum) {
        String sql = "SELECT * FROM qa WHERE qa_num = ?";
        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, qaNum);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                QaDTO dto = new QaDTO();
                dto.setQaNum(rs.getLong("qa_num"));
                dto.setType(rs.getString("type"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUserNum(rs.getObject("user_num") != null ? rs.getLong("user_num") : null);
                dto.setGuestName(rs.getString("guest_name"));
                dto.setGuestPassword(rs.getString("guest_password"));
                dto.setGuestEmail(rs.getString("guest_email"));
                dto.setStatus(rs.getString("status"));
                dto.setAnswer(rs.getString("answer"));
                dto.setCreatedAt(rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null);
                dto.setUpdatedAt(rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null);
                return dto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 글 삭제
    public int deleteQa(long qaNum) {
        String sql = "DELETE FROM qa WHERE qa_num = ?";
        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, qaNum);
            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 글 수정
    public int updateQa(QaDTO dto) {
        String sql = "UPDATE qa SET type = ?, title = ?, content = ?, updated_at = NOW() WHERE qa_num = ?";
        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dto.getType());
            ps.setString(2, dto.getTitle());
            ps.setString(3, dto.getContent());
            ps.setLong(4, dto.getQaNum());

            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 비회원 비밀번호 확인 (BCrypt 사용)
    public boolean checkGuestPassword(long qaNum, String inputPassword) {
        String sql = "SELECT guest_password FROM qa WHERE qa_num = ?";
        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, qaNum);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String dbPwd = rs.getString("guest_password");
                return dbPwd != null && BCrypt.checkpw(inputPassword, dbPwd);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 글 목록
    public List<QaDTO> getQaList(String keyword, String startDate, String endDate, int offset, int size) {
        List<QaDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM qa WHERE 1=1 ";
        if (keyword != null && !keyword.isEmpty()) sql += " AND title LIKE ? ";
        if (startDate != null && !startDate.isEmpty()) sql += " AND DATE(created_at) >= ? ";
        if (endDate != null && !endDate.isEmpty()) sql += " AND DATE(created_at) <= ? ";
        sql += " ORDER BY qa_num DESC LIMIT ?, ?";

        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            if (keyword != null && !keyword.isEmpty()) ps.setString(idx++, "%" + keyword + "%");
            if (startDate != null && !startDate.isEmpty()) ps.setString(idx++, startDate);
            if (endDate != null && !endDate.isEmpty()) ps.setString(idx++, endDate);
            ps.setInt(idx++, offset);
            ps.setInt(idx++, size);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                QaDTO dto = new QaDTO();
                dto.setQaNum(rs.getLong("qa_num"));
                dto.setType(rs.getString("type"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setGuestName(rs.getString("guest_name"));
                dto.setUserNum(rs.getObject("user_num") != null ? rs.getLong("user_num") : null);
                dto.setStatus(rs.getString("status"));
                dto.setCreatedAt(rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null);
                dto.setAnsweredAt(rs.getTimestamp("answered_at") != null ? rs.getTimestamp("answered_at").toLocalDateTime() : null);
                dto.setUpdatedAt(rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null);
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 글 개수
    public int getQaCount(String keyword, String startDate, String endDate) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM qa WHERE 1=1 ";
        if (keyword != null && !keyword.isEmpty()) sql += " AND title LIKE ? ";
        if (startDate != null && !startDate.isEmpty()) sql += " AND DATE(created_at) >= ? ";
        if (endDate != null && !endDate.isEmpty()) sql += " AND DATE(created_at) <= ? ";

        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            if (keyword != null && !keyword.isEmpty()) ps.setString(idx++, "%" + keyword + "%");
            if (startDate != null && !startDate.isEmpty()) ps.setString(idx++, startDate);
            if (endDate != null && !endDate.isEmpty()) ps.setString(idx++, endDate);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}