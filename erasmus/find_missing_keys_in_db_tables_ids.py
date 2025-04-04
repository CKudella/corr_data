import pandas as pd

# Step 1: Load the CSV files
correspondents_df = pd.read_csv('dataset/csv/era_correspondents.csv')
letters_df = pd.read_csv('dataset/csv/era_letters.csv')
locations_df = pd.read_csv('dataset/csv/era_locations.csv')

# Step 2: Extract the necessary columns
source_loc_id = letters_df['source_loc_id']
target_loc_id = letters_df['target_loc_id']
pob_loc_id = correspondents_df['pob_loc_id']  # From correspondents_df
pod_loc_id = correspondents_df['pod_loc_id']  # From correspondents_df
sender_id = letters_df['sender_id']  # From letters_df
recipient_id = letters_df['recipient_id']  # From letters_df
locations_id = locations_df['locations_id']
correspondents_id = correspondents_df['correspondents_id']

# Step 3: Find missing values in source_loc_id and target_loc_id (checked against locations)
missing_source_loc_id = set(source_loc_id) - set(locations_id)
missing_target_loc_id = set(target_loc_id) - set(locations_id)

# Step 4: Find missing values in pob_loc_id and pod_loc_id (checked against locations)
missing_pob_loc_id = set(pob_loc_id) - set(locations_id)
missing_pod_loc_id = set(pod_loc_id) - set(locations_id)

# Step 5: Find missing values in sender_id and recipient_id (checked against correspondents)
missing_sender_id = set(sender_id) - set(correspondents_id)
missing_recipient_id = set(recipient_id) - set(correspondents_id)

# Step 6: Create a report
if missing_source_loc_id:
    print("Missing source_loc_id values: ", list(missing_source_loc_id))
else:
    print("No missing source_loc_id values")

if missing_target_loc_id:
    print("Missing target_loc_id values: ", list(missing_target_loc_id))
else:
    print("No missing target_loc_id values")

if missing_pob_loc_id:
    print("Missing pob_loc_id values: ", list(missing_pob_loc_id))
else:
    print("No missing pob_loc_id values")

if missing_pod_loc_id:
    print("Missing pod_loc_id values: ", list(missing_pod_loc_id))
else:
    print("No missing pod_loc_id values")

if missing_sender_id:
    print("Missing sender_id values: ", list(missing_sender_id))
else:
    print("No missing sender_id values")

if missing_recipient_id:
    print("Missing recipient_id values: ", list(missing_recipient_id))
else:
    print("No missing recipient_id values")
