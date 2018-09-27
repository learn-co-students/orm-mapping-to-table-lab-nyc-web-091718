class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-sql
    create table students (id integer primary key, name text, grade integer);
    sql
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-sql
    Drop table students;
    sql
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-sql
    INSERT INTO students (name, grade) VALUES (?,?);
    sql
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT id FROM students")[0][0]
  end

  def self.create(attributes={})
    new = Student.new(attributes[:name], attributes[:grade])
    new.save
    new
  end

end
