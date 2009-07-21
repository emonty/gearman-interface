use lib 'blib/arch';
use lib 'blib';
use lib 'blib/lib';

use libdrizzle;

$d= new libdrizzle::Drizzle();
$c= $d->add_tcp("localhost", 3306, "root", 0, "mysql", $libdrizzle::DRIZZLE_CON_MYSQL);
$r=$c->query("SELECT User, Host FROM user");

