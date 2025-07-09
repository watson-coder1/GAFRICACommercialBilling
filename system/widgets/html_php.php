<?php

class html_php
{

    public function getWidget($data = null)
    {
        global $ui;
        $ui->assign('card_header', $data['title']);
        ob_start();
        try{
            // SECURITY: eval() removed to prevent code injection
            // Only allow safe HTML content output
            echo htmlspecialchars($data['content'], ENT_QUOTES, 'UTF-8');
        }catch(Exception $e){
            echo htmlspecialchars($e->getMessage(), ENT_QUOTES, 'UTF-8');
            echo "<br>";
            echo htmlspecialchars($e->getTraceAsString(), ENT_QUOTES, 'UTF-8');
        }
        $content = ob_get_clean();
        return $content;
    }
}