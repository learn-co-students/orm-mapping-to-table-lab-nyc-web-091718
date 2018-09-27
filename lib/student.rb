class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)

    @id = id
    @name = name
    @grade = grade

  end

  def self.create_table()
    DB[:conn].execute("CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);")
  end

  def self.drop_table()
    DB[:conn].execute("DROP TABLE students")
  end

  def save()
    DB[:conn].execute("INSERT INTO students(name,grade) VALUES (?,?);",@name,@grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid()").flatten[0]
  end

  def self.create(name:, grade:)
    student = self.new(name,grade)
    student.save
    student
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
