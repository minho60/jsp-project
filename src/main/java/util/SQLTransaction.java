package util;

import java.sql.SQLException;

@FunctionalInterface
public interface SQLTransaction {
	void execute(DBUtil.Transaction tx) throws SQLException;
}
