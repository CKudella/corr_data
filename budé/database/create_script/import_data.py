import mysql.connector
import pandas as pd

# MySQL connection settings
DB_CONFIG = {
    "host": "127.0.0.1",
    "user": "root",
    "password": "root",
    "database": "budé_cdb_v1",
}

# Paths to CSV files (in correct loading order)
CSV_FILES = [
    ("locations", "budé/dataset/csv/gbudé_locations.csv"),
    ("correspondents", "budé/dataset/csv/gbudé_correspondents.csv"),
    ("letters", "budé/dataset/csv/gbudé_letters.csv"),
]

# SQL script to create tables
SQL_SCRIPT_PATH = "budé/database/create_script/budé_cdb_v1_create_script.sql"

def connect_db():
    """Establish a connection to the MySQL database."""
    return mysql.connector.connect(**DB_CONFIG)

def execute_sql_file(cursor, file_path):
    """Execute SQL statements from a file."""
    with open(file_path, "r", encoding="utf-8") as file:
        sql_statements = file.read().split(";")  
        for statement in sql_statements:
            if statement.strip():
                cursor.execute(statement)

def clean_dataframe(df):
    """Convert empty strings and NaN values to None for MySQL compatibility."""
    df.replace("", None, inplace=True)  # Convert empty strings to NULL
    df = df.where(pd.notna(df), None)   # Convert NaN to NULL
    return df

def import_csv_to_db(cursor, table_name, csv_path):
    """Load CSV data into a MySQL table using INSERT statements."""
    df = pd.read_csv(csv_path, dtype=str)  # Read CSV as string to avoid type conversion
    df = clean_dataframe(df)  # Apply NULL handling

    # ✅ Ensure we are using the correct column names from the CSV header
    columns = ",".join([f"`{col}`" for col in df.columns])  # Escape column names with backticks
    placeholders = ",".join(["%s"] * len(df.columns))  # (%s, %s, %s, ...)
    
    query = f"INSERT INTO `{table_name}` ({columns}) VALUES ({placeholders})"

    # ✅ Skip inserting empty CSVs
    if df.empty:
        print(f"⚠️ Skipping {table_name}: CSV file is empty!")
        return

    # ✅ Batch insert the actual data rows (skip the header, which pandas already handles)
    cursor.executemany(query, df.values.tolist())

def main():
    """Main function to create tables and import CSV data in the correct order."""
    connection = connect_db()
    cursor = connection.cursor()

    try:
        # Run SQL script to create tables
        execute_sql_file(cursor, SQL_SCRIPT_PATH)
        connection.commit()
        print("✅ Tables created successfully!")

        # ✅ Import CSV data in the correct order
        for table, csv_file in CSV_FILES:
            print(f"📥 Importing {csv_file} into {table}...")
            import_csv_to_db(cursor, table, csv_file)
            connection.commit()
            print(f"✅ Data imported into {table} successfully!")

    except mysql.connector.Error as err:
        print(f"❌ Error: {err}")
    finally:
        cursor.close()
        connection.close()

if __name__ == "__main__":
    main()
