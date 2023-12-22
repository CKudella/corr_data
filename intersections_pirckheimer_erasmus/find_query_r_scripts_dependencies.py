import os
from tabulate import tabulate

def find_sql_files(directory):
    sql_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".sql"):
                sql_files.append(os.path.join(root, file))
    return sql_files

def find_matching_csv(sql_file):
    csv_file = sql_file.replace("sql_queries", "query_results").replace(".sql", ".csv")
    if os.path.exists(csv_file):
        return csv_file
    return None

def find_consumers(csv_file, r_scripts_directory):
    csv_filename = os.path.basename(csv_file)
    consumers = []

    for root, dirs, files in os.walk(r_scripts_directory):
        for file in files:
            if file.endswith(".R"):
                r_script_path = os.path.join(root, file)
                with open(r_script_path, 'r', encoding='utf-8') as r_script:
                    r_script_content = r_script.read()
                    if csv_filename in r_script_content:
                        consumers.append(os.fsdecode(os.path.relpath(os.fsencode(r_script_path), os.fsencode(os.path.dirname(__file__)))))

    return consumers

def main():
    root_directory = os.path.dirname(os.path.abspath(__file__))
    sql_queries_directory = os.path.join(root_directory, "sql_queries")
    query_results_directory = os.path.join(root_directory, "query_results")
    r_scripts_directory = os.path.join(root_directory, "r_scripts")

    sql_files = find_sql_files(sql_queries_directory)

    results = []

    for sql_file in sql_files:
        csv_file = find_matching_csv(sql_file)
        if csv_file:
            consumers = find_consumers(csv_file, r_scripts_directory)
            if consumers:
                results.append((os.fsdecode(os.path.relpath(os.fsencode(sql_file), os.fsencode(os.path.dirname(__file__)))), os.fsdecode(os.path.relpath(os.fsencode(csv_file), os.fsencode(os.path.dirname(__file__)))), consumers))

    # Sort results by SQL file
    results.sort(key=lambda x: x[0])

    # Display results as a table
    headers = ["SQL File", "Consumed by R Scripts"]
    rows = []
    for sql_file, csv_file, consumers in results:
        consumers_str = ", ".join(consumers)
        rows.append([sql_file, consumers_str])

    # Generate Markdown table
    markdown_table = tabulate(rows, headers=headers, tablefmt="pipe")

    # Write Markdown table to file
    markdown_filename = "query_r_scripts_dependencies.md"
    with open(markdown_filename, "w", encoding='utf-8') as md_file:
        md_file.write(markdown_table)

    print(f"Markdown table written to {markdown_filename}")

if __name__ == "__main__":
    main()
