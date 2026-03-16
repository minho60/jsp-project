package service.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import service.dto.EventDto;
import util.DBConnectionMgr;

public class EventDao {

    // 이벤트 총 개수
    public int getTotalCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM event";

        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // 페이징용 이벤트 목록
    public List<EventDto> selectByPage(int startRow, int pageSize) {
        List<EventDto> list = new ArrayList<>();
        String sql = "SELECT * FROM event ORDER BY id DESC LIMIT ?, ?";

        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, startRow);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EventDto dto = new EventDto();
                    dto.setId(rs.getInt("id"));
                    dto.setTab(rs.getString("tab"));
                    dto.setTitle(rs.getString("title"));
                    dto.setImg(rs.getString("img"));
                    dto.setAlt(rs.getString("alt"));
                    dto.setDate(rs.getString("date"));
                    dto.setContent(rs.getString("content"));
                    dto.setCreateTime(rs.getTimestamp("create_time"));
                    dto.setViewCount(rs.getInt("view_count"));
                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 이벤트 상세 + 조회수 증가
    public EventDto selectOne(int id) {
        EventDto dto = null;

        // 조회수 증가
        String updateSql = "UPDATE event SET view_count = view_count + 1 WHERE id=?";
        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
            psUpdate.setInt(1, id);
            psUpdate.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 상세 조회
        String sql = "SELECT * FROM event WHERE id=?";
        try (Connection conn = DBConnectionMgr.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                dto = new EventDto();
                dto.setId(rs.getInt("id"));
                dto.setTab(rs.getString("tab"));
                dto.setTitle(rs.getString("title"));
                dto.setImg(rs.getString("img"));
                dto.setAlt(rs.getString("alt"));
                dto.setDate(rs.getString("date"));
                dto.setContent(rs.getString("content"));
                dto.setCreateTime(rs.getTimestamp("create_time"));
                dto.setViewCount(rs.getInt("view_count"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto;
    }
}