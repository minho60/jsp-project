package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DBUtil {

	public static int executeUpdate(String sql, SQLConsumer setter) throws SQLException {
		try (Connection conn = DBConnectionMgr.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			if (setter != null) {
				setter.accept(ps);
			}
			return ps.executeUpdate();

		} catch (SQLException e) {
			// throw new RuntimeException(e);
			throw e;
		}
	}

	public static <T> List<T> executeQuery(String sql, SQLConsumer setter, RowMapper<T> mapper) throws SQLException {
		List<T> result = new ArrayList<>();

		try (Connection conn = DBConnectionMgr.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			if (setter != null) {
				setter.accept(ps);
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					result.add(mapper.map(rs));
				}
			}

		} catch (SQLException e) {
			// throw new RuntimeException(e);
			throw e;
		}

		return result;
	}

	public static void executeTransaction(SQLTransaction task) throws SQLException {
		Connection conn = DBConnectionMgr.getConnection();
		try {
			conn.setAutoCommit(false);
			task.execute(new Transaction(conn));
			conn.commit();
		} catch (SQLException e) {
			conn.rollback();
			throw e;
		} finally {
			conn.setAutoCommit(true);
			conn.close();
		}
	}

	public static class Transaction {
		private final Connection conn;

		Transaction(Connection conn) {
			this.conn = conn;
		}

		public int update(String sql, SQLConsumer setter) throws SQLException {
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				if (setter != null) {
					setter.accept(ps);
				}
				return ps.executeUpdate();
			}
		}

		public <T> List<T> query(String sql, SQLConsumer setter, RowMapper<T> mapper) throws SQLException {
			List<T> result = new ArrayList<>();
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				if (setter != null) {
					setter.accept(ps);
				}
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						result.add(mapper.map(rs));
					}
				}
			}
			return result;
		}
	}
}