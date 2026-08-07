import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;

public class Hack {
    public static void main(String[] args) throws Exception {
        // Store the user's input (password) inside a variable 'password'.
        Scanner scanner = new Scanner(System.in);
        System.out.println("Please, enter the new password: ");
        String password = scanner.nextLine();
        
        // Create a connection between the database and the program.
        Connection sqliteConnection = DriverManager.getConnection("jdbc:sqlite:dont-panic.db");
    
        // Store the sql query inside a 'java' string.
        String query = """
            UPDATE "users"
            SET "password" = ?
            WHERE "username" = 'admin';
        """;

        // Execute sql statement using 'java', ensuring to use the
        // '?', as placeholder (prepared statement), for a value to supply later.
        PreparedStatement sqliteStatement  = sqliteConnection.prepareStatement(query);
        sqliteStatement.setString(1, password); // Insert the password.
        sqliteStatement.executeUpdate();

        // Close connection
        sqliteConnection.close();
        
        scanner.close();
    }
}
