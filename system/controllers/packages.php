<?php

/**
 * Hotspot Package Management Controller
 */

if (!$admin) {
    r2(U . 'login', 'e', 'Access denied');
}

switch ($routes['1']) {
    case 'list':
    case '':
        $packages = ORM::for_table('tbl_hotspot_packages')
            ->order_by_asc('price')
            ->find_many();
            
        $ui->assign('packages', $packages);
        $ui->assign('_title', 'Hotspot Packages');
        $ui->display('admin/packages-list.tpl');
        break;
        
    case 'add':
        if ($routes['2'] == 'post') {
            $name = $_POST['name'];
            $price = $_POST['price'];
            $duration_hours = $_POST['duration_hours'];
            $data_limit_mb = $_POST['data_limit_mb'];
            $description = $_POST['description'];
            
            if (empty($name) || empty($price) || empty($duration_hours)) {
                r2(U . 'packages/add', 'e', 'Please fill all required fields');
            }
            
            if (!is_numeric($price) || $price <= 0) {
                r2(U . 'packages/add', 'e', 'Price must be a positive number');
            }
            
            if (!is_numeric($duration_hours) || $duration_hours <= 0) {
                r2(U . 'packages/add', 'e', 'Duration must be a positive number');
            }
            
            $package = ORM::for_table('tbl_hotspot_packages')->create();
            $package->name = $name;
            $package->price = $price;
            $package->duration_hours = $duration_hours;
            $package->data_limit_mb = empty($data_limit_mb) ? null : $data_limit_mb;
            $package->description = $description;
            $package->status = 'active';
            $package->save();
            
            r2(U . 'packages/list', 's', 'Package created successfully');
        }
        
        $ui->assign('_title', 'Add New Package');
        $ui->display('admin/packages-add.tpl');
        break;
        
    case 'edit':
        $id = $routes['2'];
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $id)
            ->find_one();
            
        if (!$package) {
            r2(U . 'packages/list', 'e', 'Package not found');
        }
        
        if ($routes['3'] == 'post') {
            $name = $_POST['name'];
            $price = $_POST['price'];
            $duration_hours = $_POST['duration_hours'];
            $data_limit_mb = $_POST['data_limit_mb'];
            $description = $_POST['description'];
            $status = $_POST['status'];
            
            if (empty($name) || empty($price) || empty($duration_hours)) {
                r2(U . 'packages/edit/' . $id, 'e', 'Please fill all required fields');
            }
            
            if (!is_numeric($price) || $price <= 0) {
                r2(U . 'packages/edit/' . $id, 'e', 'Price must be a positive number');
            }
            
            if (!is_numeric($duration_hours) || $duration_hours <= 0) {
                r2(U . 'packages/edit/' . $id, 'e', 'Duration must be a positive number');
            }
            
            $package->name = $name;
            $package->price = $price;
            $package->duration_hours = $duration_hours;
            $package->data_limit_mb = empty($data_limit_mb) ? null : $data_limit_mb;
            $package->description = $description;
            $package->status = $status;
            $package->save();
            
            r2(U . 'packages/list', 's', 'Package updated successfully');
        }
        
        $ui->assign('package', $package);
        $ui->assign('_title', 'Edit Package');
        $ui->display('admin/packages-edit.tpl');
        break;
        
    case 'delete':
        $id = $routes['2'];
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $id)
            ->find_one();
            
        if (!$package) {
            r2(U . 'packages/list', 'e', 'Package not found');
        }
        
        // Check if package is being used
        $sessions = ORM::for_table('tbl_portal_sessions')
            ->where('package_id', $id)
            ->count();
            
        if ($sessions > 0) {
            r2(U . 'packages/list', 'e', 'Cannot delete package that has been used in sessions');
        }
        
        $package->delete();
        r2(U . 'packages/list', 's', 'Package deleted successfully');
        break;
        
    case 'toggle':
        $id = $routes['2'];
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $id)
            ->find_one();
            
        if (!$package) {
            r2(U . 'packages/list', 'e', 'Package not found');
        }
        
        $package->status = ($package->status == 'active') ? 'inactive' : 'active';
        $package->save();
        
        r2(U . 'packages/list', 's', 'Package status updated');
        break;
        
    default:
        r2(U . 'packages/list');
        break;
}