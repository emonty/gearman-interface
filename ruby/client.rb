require 'drizzle/libdrizzle'

d= Libdrizzle::Drizzle.new
c= d.add_tcp("localhost", 3306, "root", "", "mysql", Libdrizzle::DRIZZLE_CON_MYSQL)
r= c.query("SELECT User, Host from user")

puts "Result:    row_count=", r.row_count()
puts "           insert_id=", r.insert_id()
puts "       warning_count=", r.warning_count()
puts "        column_count=", r.column_count()
puts "	        error_code=", r.error_code()

while true:
  column= r.column_read()
  if column:
    break
  end
  puts "Field:       catalog=", column.catalog()
  puts "                  db=", column.db()
  puts "               table=", column.table()
  puts "          orig_table=", column.orig_table()
  puts "                name=", column.name()
  puts "           orig_name=", column.orig_name()
  puts "             charset=", column.charset()
  puts "                size=", column.size()
  puts "                type=", column.type()
  puts "               flags=", column.flage()
end

while true:
  row= r.row_read()
  if row == 0:
    break
  end
  puts "Row: ", row
  x=0
  while x<r.column_count():
    x=x+1 
    f=r.field_buffer()
    puts "\t(", f.length(), ") ", f
    r.field_free(f)
  end
  puts "\n"
end
