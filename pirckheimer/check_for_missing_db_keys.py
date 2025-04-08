import pandas as pd
import sys

# Step 1: Load the CSV files
correspondents_df = pd.read_csv('dataset/csv/wpirck_correspondents.csv')
letters_df = pd.read_csv('dataset/csv/wpirck_letters.csv')
locations_df = pd.read_csv('dataset/csv/wpirck_locations.csv')

# Step 2: Extract the necessary columns
source_loc_id = letters_df['source_loc_id']
target_loc_id = letters_df['target_loc_id']
pob_loc_id = correspondents_df['pob_loc_id']
pod_loc_id = correspondents_df['pod_loc_id']
sender_id = letters_df['sender_id']
recipient_id = letters_df['recipient_id']
locations_id = locations_df['locations_id']
correspondents_id = correspondents_df['correspondents_id']

# Step 3: Validate foreign key references
errors = []

def check_missing(name, a, b):
    missing = set(a) - set(b)
    if missing:
        errors.append(f"❌ Missing {name}: {list(missing)}")
    else:
        print(f"✅ No missing {name}")

check_missing("source_loc_id", source_loc_id, locations_id)
check_missing("target_loc_id", target_loc_id, locations_id)
check_missing("pob_loc_id", pob_loc_id, locations_id)
check_missing("pod_loc_id", pod_loc_id, locations_id)
check_missing("sender_id", sender_id, correspondents_id)
check_missing("recipient_id", recipient_id, correspondents_id)

# Step 4: Handle errors
if errors:
    print("\n".join(errors))
    sys.exit(1)  # 🔥 Fail the workflow
else:
    print("🎉 All primary/foreign key checks passed.")