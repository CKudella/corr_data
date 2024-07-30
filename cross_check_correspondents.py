import pandas as pd

# Load datasets
erasmus_df = pd.read_csv('erasmus/dataset/csv/era_correspondents.csv')
bude_df = pd.read_csv('bud\u00E9/dataset/csv/gbud\u00E9_correspondents.csv')
pirckheimer_df = pd.read_csv('pirckheimer/dataset/csv/wpirck_correspondents.csv')

# Add a column to indicate the dataset name
erasmus_df['dataset'] = 'erasmus'
bude_df['dataset'] = 'gbudé'
pirckheimer_df['dataset'] = 'pirckheimer'

# Concatenate datasets
dfs = [erasmus_df, bude_df, pirckheimer_df]
combined_df = pd.concat(dfs, ignore_index=True)

# Define values to ignore in the emlo_person_id column
ignore_emlo_ids = ['34142aa0-1cd8-4f0d-9485-e802143193d9', '8cfd121a-3b13-40a3-b228-d6461c1078ff']

# Consistency check part 1: Check if all correspondents with the same correspondents_id have the same external IDs
def check_uuid_consistency(df):
    id_columns = ['viaf_id', 'wikidata_id', 'gnd_id', 'cerl_id', 'emlo_person_id']
    inconsistencies = []

    grouped_by_uuid = df.groupby('correspondents_id')
    
    for name, group in grouped_by_uuid:
        for id_col in id_columns:
            if id_col == 'emlo_person_id':
                unique_values = group[~group[id_col].isin(ignore_emlo_ids)][id_col].dropna().unique()
            else:
                unique_values = group[id_col].dropna().unique()
            if len(unique_values) > 1:
                datasets = group['dataset'].unique()
                inconsistencies.append((name, id_col, unique_values, datasets))
    
    return inconsistencies

# Consistency check part 2: Check if all correspondents with the same external IDs have the same correspondents_id
def check_id_consistency(df):
    id_columns = ['viaf_id', 'wikidata_id', 'gnd_id', 'cerl_id', 'emlo_person_id']
    inconsistencies = []

    for id_col in id_columns:
        grouped_by_id = df.groupby(id_col)
        
        for name, group in grouped_by_id:
            if pd.notna(name) and (id_col != 'emlo_person_id' or name not in ignore_emlo_ids):
                unique_uuids = group['correspondents_id'].dropna().unique()
                if len(unique_uuids) > 1:
                    datasets = group['dataset'].unique()
                    inconsistencies.append((name, id_col, unique_uuids, datasets))
    
    return inconsistencies

# Execute consistency checks
uuid_inconsistencies = check_uuid_consistency(combined_df)
id_inconsistencies = check_id_consistency(combined_df)

# Print the report
def print_report(uuid_inconsistencies, id_inconsistencies):
    has_inconsistencies = False

    if uuid_inconsistencies:
        has_inconsistencies = True
        print("Inconsistencies in correspondents_id:")
        for inconsistency in uuid_inconsistencies:
            print(f'\ncorrespondents_id: {inconsistency[0]} has inconsistent values in {inconsistency[1]}:')
            print(f'  Values: {inconsistency[2]}')
            print(f'  Affected datasets: {inconsistency[3]}')

    if id_inconsistencies:
        has_inconsistencies = True
        print("\nInconsistencies in other IDs:")
        for inconsistency in id_inconsistencies:
            print(f'\n{inconsistency[1]}: {inconsistency[0]} has inconsistent correspondents_id values:')
            print(f'  UUIDs: {inconsistency[2]}')
            print(f'  Affected datasets: {inconsistency[3]}')
    
    if not has_inconsistencies:
        print("No inconsistencies found.")
    return has_inconsistencies

# Print the report and determine the exit status
has_inconsistencies = print_report(uuid_inconsistencies, id_inconsistencies)
if has_inconsistencies:
    exit(1)  # Indicate failure
else:
    exit(0)  # Indicate success
