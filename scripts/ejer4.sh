#!/bin/bash

for user_perm in {0..7}; do
    for group_perm in {0..7}; do
        for other_perm in {0..7}; do
            file_name="file_${user_perm}_${group_perm}_${other_perm}"
            file_permissions="${user_perm}${group_perm}${other_perm}"
            
            touch "$file_name"
            chmod "$file_permissions" "$file_name"
            echo "Creado archivo: $file_name con permisos $file_permissions"
        done
    done
done
