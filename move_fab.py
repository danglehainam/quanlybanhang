import os
import re

buttons_dir = 'lib/presentation/widgets/buttons'
fab_file = 'app_floating_action_button.dart'

# Move file
src = f'lib/presentation/widgets/{fab_file}'
dst = f'{buttons_dir}/{fab_file}'
if os.path.exists(src):
    os.rename(src, dst)

# Update imports in all dart files
for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()
            
            original_content = content
            # Replace 'widgets/app_floating_action_button.dart' -> 'widgets/buttons/app_floating_action_button.dart'
            content = content.replace(f'widgets/{fab_file}', f'widgets/buttons/{fab_file}')
            
            # Replace import '../app_floating_action_button.dart'; -> import '../buttons/app_floating_action_button.dart';
            content = content.replace(f"import '../{fab_file}'", f"import '../buttons/{fab_file}'")
            content = content.replace(f"import '{fab_file}'", f"import 'buttons/{fab_file}'")
            
            # Fix double 'buttons/buttons/' just in case
            content = content.replace(f'buttons/buttons/{fab_file}', f'buttons/{fab_file}')
            
            if content != original_content:
                with open(filepath, 'w') as f:
                    f.write(content)
                print(f"Updated {filepath}")
