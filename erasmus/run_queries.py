import os
import mysql.connector
import pandas as pd
import csv  # Import CSV module for quoting options

# MySQL connection settings
DB_CONFIG = {
    "host": "127.0.0.1",
    "user": "root",
    "password": "root",
    "database": "era_cdb",
}

# Paths
QUERY_DIR = "erasmus/sql_queries"
RESULTS_DIR = "erasmus/query_results"

def connect_db():
    """Establish a connection to the MySQL database."""
    return mysql.connector.connect(**DB_CONFIG)

def run_query(cursor, sql_file):
    """Execute a SQL query and return the results as a DataFrame."""
    with open(sql_file, "r", encoding="utf-8") as file:
        query = file.read()
    cursor.execute(query)
    columns = [col[0] for col in cursor.description]  # Get column names
    results = cursor.fetchall()

    # Convert all data to a DataFrame
    df = pd.DataFrame(results, columns=columns)

    # Replace NaN values with "NULL"
    df = df.fillna("NULL")

    # Convert everything to strings
    df = df.astype(str)

    # Remove trailing ".0" from integer-like floats **without affecting actual decimals**
    df = df.map(lambda x: x[:-2] if isinstance(x, str) and x.endswith(".0") and x.count(".") == 1 and x.replace(".", "").isdigit() else x)

    return df

def save_results(df, output_path):
    """Save query results to a CSV file with all cells enclosed in double quotes."""
    os.makedirs(os.path.dirname(output_path), exist_ok=True)  # Ensure subdirectories exist
    df.to_csv(output_path, index=False, quotechar='"', quoting=csv.QUOTE_ALL)
    print(f"✅ Saved: {output_path}")

def main():
    """Find and execute all SQL queries, then save results as CSV files in matching subfolders."""
    connection = connect_db()
    cursor = connection.cursor()

    for root, _, files in os.walk(QUERY_DIR):
        for file in files:
            if file.endswith(".sql"):
                sql_path = os.path.join(root, file)
                
                # Maintain the subfolder structure from `sql_queries` inside `query_results`
                relative_path = os.path.relpath(sql_path, QUERY_DIR)  
                csv_path = os.path.join(RESULTS_DIR, os.path.splitext(relative_path)[0] + ".csv")

                print(f"📥 Running query: {sql_path}")
                df = run_query(cursor, sql_path)

                if not df.empty:
                    save_results(df, csv_path)
                else:
                    print(f"⚠️ No results for {sql_path}")

    cursor.close()
    connection.close()

if __name__ == "__main__":
    main()
