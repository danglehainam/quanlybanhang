import os
import re

buttons_dir = 'lib/presentation/widgets/buttons'
os.makedirs(buttons_dir, exist_ok=True)

button_files = [
    'app_primary_button.dart',
    'app_text_button.dart',
    'app_filled_button.dart',
    'app_icon_button.dart'
]

# Move files
for bf in button_files:
    src = f'lib/presentation/widgets/{bf}'
    dst = f'{buttons_dir}/{bf}'
    if os.path.exists(src):
        os.rename(src, dst)

# Update imports in all dart files
for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r') as f:
                content = f.read()
            
            # Cases:
            # 1. import '../../../widgets/app_primary_button.dart';
            # -> import '../../../widgets/buttons/app_primary_button.dart';
            # 2. import 'app_primary_button.dart'; (if inside widgets folder)
            # -> import 'buttons/app_primary_button.dart';
            # 3. import '../app_primary_button.dart'; (from inside layout folder)
            # -> import '../buttons/app_primary_button.dart';
            
            original_content = content
            for bf in button_files:
                # Replace 'widgets/app_primary_button.dart' -> 'widgets/buttons/app_primary_button.dart'
                content = content.replace(f'widgets/{bf}', f'widgets/buttons/{bf}')
                
                # Replace import '../app_primary_button.dart'; -> import '../buttons/app_primary_button.dart';
                # This specifically applies to layout/app_header.dart or similar
                content = content.replace(f"import '../{bf}'", f"import '../buttons/{bf}'")
                content = content.replace(f"import '{bf}'", f"import 'buttons/{bf}'")
                
                # Fix double 'buttons/buttons/' in case it matched multiple times (just in case)
                content = content.replace(f'buttons/buttons/{bf}', f'buttons/{bf}')
                
            if content != original_content:
                with open(filepath, 'w') as f:
                    f.write(content)
                print(f"Updated {filepath}")

