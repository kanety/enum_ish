class CreateUsers < ActiveRecord::Migration::Current
  def change
    create_table :users do |t|
      t.string  :str
      t.integer :int
      t.float   :flt
      t.boolean :bool

      t.string  :aliased_str
      t.integer :aliased_int
      t.float   :aliased_flt
      t.boolean :aliased_bool

      t.string  :status
    end
  end
end
