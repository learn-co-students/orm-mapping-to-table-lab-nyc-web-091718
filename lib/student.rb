class Student
  attr_accessor :name, :grade
  attr_reader :id
  ALL = []

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def self.create(properties={})
    student= Student.new("","")
    properties.each {|property, value| student.send("#{property}=", value)}
    student.save
    student
  end

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
    ALL << self
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES (?,?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    update_id(id)
  end

  private
  def update_id(id)
    @id = id
  end

end
