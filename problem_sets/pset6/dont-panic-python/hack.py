from cs50 import SQL

# Establish the connection to the dont-panic database.
db = SQL("sqlite:///dont-panic.db")

# Create a variable to store the user defined password.
password = input("Please, enter a password: ")

# Execute sql statement with Python, ensuring to use the
# '?', from the cs50's library, as placeholder (prepared statement),
# for a value to supply later.
db.execute(
    """
    UPDATE "users"
    SET "password" = ?
    WHERE "username" = 'admin';
    """,
    # Tell the execute statement which value to replace
    # the question mark with.
    password
)