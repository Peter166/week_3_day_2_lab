require('pry-byebug')

require_relative('models/property.rb')

Property.delete_all()

property1 = Property.new(
  {'address' => '21 Hell, Glasgow',
  'value' => '120000',
  'bedrooms' => '2',
  'status' => 'buy'}
)

property2 = Property.new(
  {'address' => '34 Whatever, Glasgow',
  'value' => '89000',
  'bedrooms' => '1',
  'status' => 'let'}
)

property3 = Property.new(
  {'address' => '60 Hell NO, Glasgow',
  'value' => '100001',
  'bedrooms' => '3',
  'status' => 'buy'}
)

property1.save()
property2.save()
property3.save()
property1.delete()

property2.value = 85000
property2.update()

binding.pry
Property.find('id', 5)


binding.pry
nil
