<?php

$com_1 = array('id'=>5,'parent'=>0, 'text'=>'some text for 5');
$com_2 = array('id'=>6,'parent'=>0, 'text'=>'some text for 6');
$com_3 = array('id'=>7,'parent'=>5, 'text'=>'some text for 7');
$com_4 = array('id'=>8,'parent'=>7, 'text'=>'some text for 8');
$com_5 = array('id'=>9,'parent'=>6, 'text'=>'some text for 9');

$array = array($com_1,$com_2,$com_3,$com_4,$com_5);
/*
$tree = array(); 
$sub = array(0 => &$tree ,$tree); 

foreach ($array as $item) {
    $id = $item['id']; 
    $parent = $item['parent']; 

    $branch = &$sub[$parent]; 
    $branch[$id] = array(); 
    $sub[$id] = &$branch[$id];

    
}*/


function buildTree(array &$elements, $parentId = 0) {
    $branch = array();

    foreach ($elements as $element) {
        if ($element['parent'] == $parentId) {
            $children = buildTree($elements, $element['id']);
            if ($children) {
                $element['children'] = $children;
            }
            $branch[$element['id']] = $element;
            unset($elements[$element['id']]);
        }
    }
    return $branch;
}

echo '<pre>';
print_r(buildTree($array)); 
echo '</pre>';
