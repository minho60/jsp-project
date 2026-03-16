package util;

import java.sql.PreparedStatement;
import java.sql.SQLException;

@FunctionalInterface
public interface SQLConsumer {
	void accept(PreparedStatement ps) throws SQLException;
}
