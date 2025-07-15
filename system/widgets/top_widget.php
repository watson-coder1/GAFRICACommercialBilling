<?php


class top_widget
{
    public function getWidget()
    {
        global $ui, $current_date, $start_date;

        $iday = ORM::for_table('tbl_transactions')
            ->where('recharged_on', $current_date)
            ->where_not_equal('method', 'Customer - Balance')
            ->where_not_equal('method', 'Recharge Balance - Administrator')
            ->sum('price');

        if ($iday == '') {
            $iday = '0.00';
        }
        $ui->assign('iday', $iday);

        $imonth = ORM::for_table('tbl_transactions')
            ->where_not_equal('method', 'Customer - Balance')
            ->where_not_equal('method', 'Recharge Balance - Administrator')
            ->where_gte('recharged_on', $start_date)
            ->where_lte('recharged_on', $current_date)->sum('price');
        if ($imonth == '') {
            $imonth = '0.00';
        }
        $ui->assign('imonth', $imonth);

        // Get REAL active users (not expired)
        $u_act = ORM::for_table('tbl_user_recharges')
            ->where('status', 'on')
            ->where_raw("CONCAT(expiration, ' ', time) > NOW()")
            ->count();
        if (empty($u_act)) {
            $u_act = '0';
        }
        $ui->assign('u_act', $u_act);

        // Get REAL expired users (bought but expired)
        $u_expired = ORM::for_table('tbl_user_recharges')
            ->where('status', 'on')
            ->where_raw("CONCAT(expiration, ' ', time) <= NOW()")
            ->count();
        if (empty($u_expired)) {
            $u_expired = '0';
        }
        $ui->assign('u_expired', $u_expired);

        $u_all = ORM::for_table('tbl_user_recharges')->count();
        if (empty($u_all)) {
            $u_all = '0';
        }
        $ui->assign('u_all', $u_all);


        $c_all = ORM::for_table('tbl_customers')->count();
        if (empty($c_all)) {
            $c_all = '0';
        }
        $ui->assign('c_all', $c_all);
        return $ui->fetch('widget/top_widget.tpl');
    }
}
