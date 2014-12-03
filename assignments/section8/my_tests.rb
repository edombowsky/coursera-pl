# University of Washington, Programming Languages, Homework 7, 
# hw7testsprovided.rb

require "./hw7.rb"

#  Will not work completely until you implement all the classes and their methods

# Will print only if code has errors; prints nothing if all tests pass

# These tests do NOT cover all the various cases, especially for intersection

#Constants for testing
ZERO = 0.0
ONE = 1.0
TWO = 2.0
THREE = 3.0
FOUR = 4.0
FIVE = 5.0
SIX = 6.0
SEVEN = 7.0
EIGHT = 8.0
NINE = 9.0
TEN = 10.0

require "test/unit"

class Section8 < Test::Unit::TestCase

  def test_point
    a  = Point.new(THREE,FIVE)
    a1 = a.shift(THREE,FIVE)
    a2 = a.intersect(Point.new(THREE,FIVE))
    a3 = a.intersect(Point.new(FOUR,FIVE))

    assert_equal THREE, a.x,  "Point is not initialized properly"
    assert_equal FIVE,  a.y,  "Point is not initialized properly"
    assert_equal SIX,   a1.x, "Point shift not working properly"
    assert_equal TEN,   a1.y, "Point shift not working properly"

    assert_equal a, a.eval_prog([]),   "Point eval_prog should return self"
    assert_equal a, a.preprocess_prog, "Point preprocess_prog should return self"

    assert (a3.is_a? NoPoints), "Point intersect not working properly"
    assert_equal THREE, a2.x, "Point intersect not working properly"
    assert_equal FIVE,  a2.y, "Point intersect not working properly"
  end


  def test_line
    b  = Line.new(THREE,FIVE)
    b1 = b.shift(THREE,FIVE)
    b2 = b.intersect(Line.new(THREE,FIVE))
    b3 = b.intersect(Line.new(THREE,FOUR))

    assert_equal THREE, b.m, "Line not initialized properly"
    assert_equal FIVE,  b.b, "Line not initialized properly"

    assert_equal b, b.eval_prog([]), "Line eval_prog should return self"
    assert_equal b, b.preprocess_prog , "Line preprocess_prog should return self"

    assert_equal THREE, b1.m, "Line shift not working properly"
    assert_equal ONE,   b1.b, "Line shift not working properly"

    assert (b2.is_a? Line), "Line intersect not working properly"
    assert_equal THREE, b2.m, "Line intersect not working properly"
    assert_equal FIVE,  b2.b, "Line intersect not working properly"

    assert (b3.is_a? NoPoints), "Line intersect not working properly"
  end

  def test_vertical_lines
    c  = VerticalLine.new(THREE)
    c1 = c.shift(THREE,FIVE)
    c2 = c.intersect(VerticalLine.new(THREE))
    c3 = c.intersect(VerticalLine.new(FOUR))

    assert_equal THREE, c.x, "VerticalLine not initialized properly"

    assert_equal c, c.eval_prog([]),   "VerticalLine eval_prog should return self"
    assert_equal c, c.preprocess_prog, "VerticalLine preprocess_prog should return self"

    assert_equal SIX, c1.x , "VerticalLine shift not working properly"

    assert (c2.is_a? VerticalLine), "VerticalLine intersect not working properly"
    assert_equal THREE, c2.x, "VerticalLine intersect not working properly"
    assert (c3.is_a? NoPoints), "VerticalLine intersect not working properly"

  end

  def test_line_segments
    d  = LineSegment.new(ONE,TWO,-THREE,-FOUR)
    d1 = LineSegment.new(ONE,TWO,ONE,TWO)
    d2 = d1.preprocess_prog
    d  = d.preprocess_prog
    d3 = d.shift(THREE,FIVE)
    d4 = d.intersect(LineSegment.new(-THREE,-FOUR,ONE,TWO))
    d5 = d.intersect(LineSegment.new(TWO,THREE,FOUR,FIVE))

    assert_equal d, d.eval_prog([]), "LineSegement eval_prog should return self"

    assert (d2.is_a? Point), "Segment preprocess_prog should convert to a Point\nif ends of segment are real_close"
    assert_equal ONE, d2.x, "Segment preprocess_prog should convert to a Point\nif ends of segment are real_close"
    assert_equal TWO, d2.y, "Segment preprocess_prog should convert to a Point\nif ends of segment are real_close"

    assert_equal -THREE, d.x1, "LineSegment preprocess_prog should make x1 and y1 on the left of x2 and y2"
    assert_equal -FOUR,  d.y1, "LineSegment preprocess_prog should make x1 and y1 on the left of x2 and y2"
    assert_equal  ONE,   d.x2, "LineSegment preprocess_prog should make x1 and y1 on the left of x2 and y2"
    assert_equal  TWO,   d.y2, "LineSegment preprocess_prog should make x1 and y1 on the left of x2 and y2"

    assert_equal ZERO,  d3.x1, "LineSegment shift not working properly"
    assert_equal ONE,   d3.y1, "LineSegment shift not working properly"
    assert_equal FOUR,  d3.x2, "LineSegment shift not working properly"
    assert_equal SEVEN, d3.y2, "LineSegment shift not working properly"

    assert (d4.is_a? LineSegment), "LineSegment intersect not working properly"
    assert_equal -THREE, d4.x1, "LineSegment intersect not working properly"
    assert_equal -FOUR,  d4.y1, "LineSegment intersect not working properly"
    assert_equal  ONE,   d4.x2, "LineSegment intersect not working properly"
    assert_equal  TWO,   d4.y2, "LineSegment intersect not working properly"

    assert (d5.is_a? NoPoints), "LineSegment intersect not working properly"
  end

  def test_intersections
    i  = Intersect.new(LineSegment.new(-ONE,-TWO,THREE,FOUR), LineSegment.new(THREE,FOUR,-ONE,-TWO))
    i1 = i.preprocess_prog.eval_prog([])

    assert_equal -ONE,   i1.x1, "Intersect eval_prog should return the intersect between e1 and e2"
    assert_equal -TWO,   i1.y1, "Intersect eval_prog should return the intersect between e1 and e2"
    assert_equal  THREE, i1.x2, "Intersect eval_prog should return the intersect between e1 and e2"
    assert_equal  FOUR,  i1.y2, "Intersect eval_prog should return the intersect between e1 and e2"
  end

  def test_vars
    v  = Var.new("a")
    v1 = v.eval_prog([["a", Point.new(THREE,FIVE)]])

    assert (v1.is_a? Point),  "Var eval_prog is not working properly"
    assert_equal THREE, v1.x, "Var eval_prog is not working properly"
    assert_equal FIVE,  v1.y, "Var eval_prog is not working properly"

    assert_equal v1, v1.preprocess_prog , "Var preprocess_prog should return self"
  end

  def test_let
    l = Let.new("a",
                LineSegment.new(-ONE,-TWO,THREE,FOUR),
                Intersect.new(Var.new("a"),
                              LineSegment.new(THREE,FOUR,-ONE,-TWO)))
    l1 = l.preprocess_prog.eval_prog([])

    assert_equal -ONE,   l1.x1, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
    assert_equal -TWO,   l1.y1, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
    assert_equal  THREE, l1.x2, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
    assert_equal  FOUR,  l1.y2, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
  end

  def test_let_variable_shadowing
    l2 = Let.new("a", LineSegment.new(-ONE, -TWO, THREE, FOUR),
                 Let.new("b", LineSegment.new(THREE,FOUR,-ONE,-TWO),
                         Intersect.new(Var.new("a"),Var.new("b"))))
    l2 = l2.preprocess_prog.eval_prog([["a",Point.new(0,0)]])

    assert_equal -ONE,   l2.x1, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
    assert_equal -TWO,   l2.y1, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
    assert_equal  THREE, l2.x2, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
    assert_equal  FOUR,  l2.y2, "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
  end

  def test_shift
    s  = Shift.new(THREE,FIVE,LineSegment.new(-ONE,-TWO,THREE,FOUR))
    s1 = s.preprocess_prog.eval_prog([])

    assert_equal TWO,   s1.x1, "Shift should shift e by dx and dy"
    assert_equal THREE, s1.y1, "Shift should shift e by dx and dy"
    assert_equal SIX,   s1.x2, "Shift should shift e by dx and dy"
    assert_equal NINE,  s1.y2, "Shift should shift e by dx and dy"
  end

  #============================================================================
  # FROM HERE TO THE END ARE ADDED TEST CASES
  #============================================================================

  def test_misc
    assert_equal NoPoints.new.preprocess_prog, NoPoints.new

    assert_equal Point.new(ONE, ONE), Point.new(ONE, ONE).preprocess_prog
    assert_equal Point.new(ONE, ONE), LineSegment.new(ONE, ONE, ONE, ONE).preprocess_prog

    assert_equal Line.new(ONE, TWO), Line.new(ONE, TWO).preprocess_prog

    assert_equal VerticalLine.new(TWO), VerticalLine.new(TWO).preprocess_prog

    assert_equal LineSegment.new(ONE, ONE,  ONE, TWO),  LineSegment.new(ONE, ONE, ONE, TWO).preprocess_prog
    assert_equal LineSegment.new(ONE, ZERO, ONE, ONE),  LineSegment.new(ONE, ONE, ONE, ZERO).preprocess_prog
    assert_equal LineSegment.new(ONE, ONE,  TWO, ONE),  LineSegment.new(ONE, ONE, TWO, ONE).preprocess_prog
    assert_equal LineSegment.new(ONE, ZERO, TWO, ONE),  LineSegment.new(ONE, ZERO, TWO, ONE).preprocess_prog
    assert_equal LineSegment.new(ONE, ONE,  TWO, ZERO), LineSegment.new(ONE, ONE, TWO, ZERO).preprocess_prog
    assert_equal LineSegment.new(ONE, ONE,  TWO, ONE),  LineSegment.new(TWO, ONE, ONE, ONE).preprocess_prog
    assert_equal LineSegment.new(ONE, ONE,  TWO, ZERO), LineSegment.new(TWO, ZERO, ONE, ONE).preprocess_prog
    assert_equal LineSegment.new(ONE, ZERO, TWO, ONE),  LineSegment.new(TWO, ONE, ONE, ZERO).preprocess_prog
    assert_equal LineSegment.new(ONE, TWO, 1.00000999, ONE), LineSegment.new(1.00000999, ONE, ONE, TWO).preprocess_prog

    assert_equal Intersect.new(Point.new(ONE, ONE), LineSegment.new(ONE, ZERO, TWO, ONE)), Intersect.new(LineSegment.new(ONE, ONE, ONE, ONE), LineSegment.new(TWO, ONE, ONE, ZERO)).preprocess_prog
    assert_equal Intersect.new(Point.new(3.2, 4.1), Point.new(3.2, 4.1)),                  Intersect.new(LineSegment.new(3.2,4.1,3.2,4.1), LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog
    assert_equal Let.new("x", Point.new(ONE, ONE), Var.new("x")),        Let.new("x", LineSegment.new(ONE, ONE, ONE, ONE), Var.new("x")).preprocess_prog
    assert_equal Let.new("a", Point.new(3.2, 4.1), Point.new(3.2, 4.1)), Let.new("a", LineSegment.new(3.2,4.1,3.2,4.1), LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog
    assert_equal Shift.new(ONE, ONE, Point.new(ONE, ONE)),  Shift.new(ONE, ONE, LineSegment.new(ONE, ONE, ONE, ONE)).preprocess_prog
    assert_equal Shift.new(ONE, TWO, Point.new(3.2, 4.1)),  Shift.new(ONE, TWO, LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog
    assert_equal Shift.new(ONE, ONE, Intersect.new(Point.new(ONE, ONE), LineSegment.new(ONE, ZERO, TWO, ONE))), Shift.new(ONE, ONE, Intersect.new(LineSegment.new(ONE, ONE, ONE, ONE), LineSegment.new(TWO, ONE, ONE, ZERO))).preprocess_prog
  end

  def test_eval_prog_added
    assert_equal Point.new(THREE, FOUR),                   Shift.new(ONE, ONE, Point.new(TWO, THREE)).eval_prog([])
    assert_equal Line.new(THREE, 9.3),                     Shift.new(TWO, 10.3, Line.new(THREE, FIVE)).eval_prog([])
    assert_equal VerticalLine.new(6.0),                    Shift.new(ONE, TWO, VerticalLine.new(FIVE)).eval_prog([])
    assert_equal Point.new(THREE, THREE),                  Shift.new(TWO, TWO, LineSegment.new(ONE, ONE, ONE, ONE)).preprocess_prog.eval_prog([])
    assert_equal LineSegment.new(TWO, THREE, FOUR, FIVE),  Shift.new(ONE, TWO, LineSegment.new(ONE, ONE, THREE, THREE)).preprocess_prog.eval_prog([])
    assert_equal Point.new(FOUR, FOUR),                    Shift.new(ONE, ONE, Shift.new(ONE, ONE, Shift.new(ONE, ONE, Point.new(ONE, ONE)))).preprocess_prog.eval_prog([])
    assert_equal Point.new(SEVEN, EIGHT),                  Shift.new(THREE, FOUR, Point.new(FOUR, FOUR)).eval_prog([])
    assert_equal Line.new(FOUR, -FOUR),                    Shift.new(THREE, FOUR, Line.new(FOUR, FOUR)).eval_prog([])
    assert_equal VerticalLine.new(SEVEN),                  Shift.new(THREE, FOUR, VerticalLine.new(FOUR)).eval_prog([])
    assert_equal LineSegment.new(SEVEN, SEVEN, 15.0, TWO), Shift.new(THREE, FOUR, LineSegment.new(FOUR, THREE, 12.0, -TWO)).eval_prog([])
  end

  def test_let_added
    assert_equal Point.new(TWO, THREE),                                 Let.new("x", Point.new(TWO, THREE), Var.new("x")).preprocess_prog.eval_prog([])
    assert_equal Line.new(THREE, FIVE),                                 Let.new("x", Line.new(THREE, FIVE), Var.new("x")).preprocess_prog.eval_prog([])
    assert_equal VerticalLine.new(ONE),                                 Let.new("x", VerticalLine.new(ONE), Var.new("x")).preprocess_prog.eval_prog([])
    assert_equal LineSegment.new(ONE, ONE, TWO, TWO),                   Let.new("x", LineSegment.new(TWO, TWO, ONE, ONE), Var.new("x")).preprocess_prog.eval_prog([])
    assert_equal Point.new(TWO, TWO), Let.new("x", Point.new(ONE, ONE), Let.new("x", Point.new(TWO, TWO), Var.new("x"))).preprocess_prog.eval_prog([])
  end

  def test_let_shift_added
    assert_equal Point.new(TWO, TWO),     Let.new("x", LineSegment.new(ONE, ONE, ONE, ONE), Shift.new(ONE, ONE, Var.new("x"))).preprocess_prog.eval_prog([])
    assert_equal VerticalLine.new(THREE), Shift.new(ONE, ONE, Let.new("x", VerticalLine.new(TWO), Var.new("x"))).preprocess_prog.eval_prog([])
  end

  def test_intersect_nopoints
    assert_equal NoPoints.new, Intersect.new(NoPoints.new, NoPoints.new).preprocess_prog.eval_prog([]), NoPoints.new
    assert_equal NoPoints.new, Intersect.new(NoPoints.new, Point.new(ONE, TWO)).preprocess_prog.eval_prog([]), NoPoints.new
    assert_equal NoPoints.new, Intersect.new(NoPoints.new, Line.new(ONE, ONE)).preprocess_prog.eval_prog([]), NoPoints.new
    assert_equal NoPoints.new, Intersect.new(NoPoints.new, VerticalLine.new(ONE)).preprocess_prog.eval_prog([])
    assert_equal NoPoints.new, Intersect.new(NoPoints.new, LineSegment.new(ONE, ONE, THREE, THREE)).preprocess_prog.eval_prog([])
    assert_equal NoPoints.new, Intersect.new(Point.new(ONE, ONE), Point.new(1.0999, ONE)).preprocess_prog.eval_prog([])
    assert_equal Point.new(1.00000999, ONE), Intersect.new(Point.new(ONE, ONE), Point.new(1.00000999, ONE)).preprocess_prog.eval_prog([])
  end

  def test_intersect_point
    assert_equal Point.new(ONE, FOUR),  Intersect.new(Point.new(ONE, FOUR), Line.new(ONE, THREE)).preprocess_prog.eval_prog([])
    assert_equal NoPoints.new,          Intersect.new(Point.new(TWO, FOUR), Line.new(ONE, THREE)).preprocess_prog.eval_prog([])
    assert_equal Point.new(FOUR, FOUR), Intersect.new(Point.new(FOUR, FOUR), Point.new(FOUR, FOUR)).eval_prog([])
    assert_equal NoPoints.new.class,    Intersect.new(Point.new(FOUR, FOUR), Point.new(FOUR, 4.1)).eval_prog([]).class
    assert_equal NoPoints.new.class,    Intersect.new(Point.new(FOUR, FOUR), Line.new(FOUR, 4.1)).eval_prog([]).class
    assert_equal Point.new(ONE, EIGHT), Intersect.new(Point.new(ONE, EIGHT), Line.new(FOUR, FOUR)).eval_prog([])
  end

  def test_intersect_line
    assert_equal Point.new(TWO, FOUR),  Intersect.new(Line.new(ONE, TWO), Line.new(TWO, ZERO)).preprocess_prog.eval_prog([])
    assert_equal NoPoints.new,          Intersect.new(Line.new(ONE, TWO), Line.new(ONE, THREE)).preprocess_prog.eval_prog([])
    assert_equal Point.new(TWO, FOUR),  Intersect.new(Line.new(ONE, TWO), VerticalLine.new(TWO)).preprocess_prog.eval_prog([])
    assert_equal Point.new(ONE, EIGHT), Intersect.new(Line.new(FOUR, FOUR), Point.new(ONE, EIGHT)).eval_prog([])
    assert_equal NoPoints.new.class,    Intersect.new(Line.new(FOUR, FOUR), Point.new(FOUR, 4.1)).eval_prog([]).class
    assert_equal NoPoints.new.class,    Intersect.new(Line.new(FOUR, FOUR), Line.new(FOUR, 4.1)).eval_prog([]).class
    assert_equal Point.new(ONE, EIGHT), Intersect.new(Line.new(ONE, SEVEN), Line.new(FOUR, FOUR)).eval_prog([])
    assert_equal Point.new(FOUR, 20.0), Intersect.new(Line.new(FOUR, FOUR), VerticalLine.new(FOUR)).eval_prog([])
  end

  def test_intyersect_verticle_line
    assert_equal NoPoints.new,           Intersect.new(VerticalLine.new(ONE), VerticalLine.new(TWO)).preprocess_prog.eval_prog([])
    assert_equal Point.new(FOUR, 20.0),  Intersect.new(VerticalLine.new(FOUR), Line.new(FOUR, FOUR)).eval_prog([])
    assert_equal NoPoints.new.class,     Intersect.new(VerticalLine.new(FOUR), VerticalLine.new(4.1)).eval_prog([]).class
    assert_equal VerticalLine.new(FOUR), Intersect.new(VerticalLine.new(FOUR), VerticalLine.new(FOUR)).eval_prog([])
  end

  def test_intersect_line_segment
    assert_equal NoPoints.new, Intersect.new(LineSegment.new(ZERO, ZERO, ZERO, FOUR), LineSegment.new(ONE, ZERO, ONE, FOUR)).preprocess_prog.eval_prog([])
    assert_equal NoPoints.new, Intersect.new(LineSegment.new(ZERO, ZERO, FOUR, ZERO), LineSegment.new(ZERO, ONE, FOUR, ONE)).preprocess_prog.eval_prog([])
    assert_equal LineSegment.new(ZERO, ONE, ZERO, THREE), Intersect.new(LineSegment.new(ZERO, ZERO, ZERO, FOUR), LineSegment.new(ZERO, ONE, ZERO, THREE)).preprocess_prog.eval_prog([])
    assert_equal LineSegment.new(ZERO, ONE, ZERO, THREE), Intersect.new(LineSegment.new(ZERO, ONE, ZERO, THREE), LineSegment.new(ZERO, ZERO, ZERO, FOUR)).preprocess_prog.eval_prog([])
    assert_equal LineSegment.new(ZERO, ONE, ZERO, THREE), Intersect.new(LineSegment.new(ZERO, ONE, ZERO, THREE), LineSegment.new(ZERO, ONE, ZERO, THREE)).preprocess_prog.eval_prog([])
    assert_equal LineSegment.new(ZERO, ONE, ZERO, THREE), Intersect.new(LineSegment.new(ZERO, ZERO, ZERO, THREE), LineSegment.new(ZERO, ONE, ZERO, FOUR)).preprocess_prog.eval_prog([])
  end

  def test_intersection_with_lineSegment_and_point_line_verticalline
    assert_equal NoPoints.new.class, Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), Point.new(4.1, 4.1)).eval_prog([]).class
    assert_equal NoPoints.new.class, Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), Line.new(-ONE, ONE)).eval_prog([]).class
    assert_equal NoPoints.new.class, Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), VerticalLine.new(4.1)).eval_prog([]).class
  end

  def test_intersection_between_a_vertical_line_segment_and_point_line_verticalLine
    assert_equal NoPoints.new.class,                   Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), Line.new(-ONE, ONE)).eval_prog([]).class
    assert_equal NoPoints.new.class,                   Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), VerticalLine.new(4.1)).eval_prog([]).class
    assert_equal LineSegment.new(ONE, ONE, ONE, FOUR), Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), VerticalLine.new(ONE)).eval_prog([])
  end

  def test_intersection_between_two_oblique_line_segments
    assert_equal NoPoints.new.class,                      Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(4.1, 4.1, FIVE, FIVE)).eval_prog([]).class
    assert_equal LineSegment.new(TWO, TWO, THREE, THREE), Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(TWO, TWO, THREE, THREE)).eval_prog([])
    assert_equal LineSegment.new(ONE, ONE, THREE, THREE), Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(-ONE, -ONE, THREE, THREE)).eval_prog([])
    assert_equal LineSegment.new(TWO, TWO, FOUR, FOUR),   Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(TWO, TWO, FIVE, FIVE)).eval_prog([])
    assert_equal Point.new(FOUR, FOUR),                   Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(FOUR, FOUR, FIVE, FIVE)).eval_prog([])
    assert_equal Point.new(ONE, ONE),                     Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(-FOUR, -FOUR, ONE, ONE)).eval_prog([])
    assert_equal LineSegment.new(TWO, TWO, THREE, THREE), Intersect.new(LineSegment.new(TWO, TWO, THREE, THREE), LineSegment.new(ONE, ONE, FIVE, FIVE)).eval_prog([])
  end

  def test_intersection_between_two_vertical_line_segments
    assert_equal NoPoints.new.class,                    Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, 4.1, ONE, FIVE)).eval_prog([]).class
    assert_equal LineSegment.new(ONE, TWO, ONE, THREE), Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, TWO, ONE, THREE)).eval_prog([])
    assert_equal LineSegment.new(ONE, ONE, ONE, THREE), Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, -ONE, ONE, THREE)).eval_prog([])
    assert_equal LineSegment.new(ONE, TWO, ONE, FOUR),  Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, TWO, ONE, FIVE)).eval_prog([])
    assert_equal LineSegment.new(ONE, TWO, ONE, THREE), Intersect.new(LineSegment.new(ONE, TWO, ONE, THREE), LineSegment.new(ONE, ONE, ONE, FIVE)).eval_prog([])
  end
end

## ============================================================================
## ADDED TEST CASE HELPER CLASSES
## ============================================================================

class GeometryExpression
    def real_close(r1,r2)
        (r1 - r2).abs < GeometryExpression::Epsilon
    end
    def real_close_point(x1,y1,x2,y2)
        real_close(x1,x2) && real_close(y1,y2)
    end
end

class NoPoints < GeometryValue
  def ==(np)
    self.class == np.class
  end
end

class Point < GeometryValue
  def ==(p)
    self.class == p.class and real_close_point(@x, @y, p.x, p.y)
  end
end

class Line < GeometryValue
  def ==(l)
    self.class == l.class and real_close_point(@m, @b, l.m, l.b)
  end
end

class VerticalLine < GeometryValue
  def ==(vl)
    self.class == vl.class and real_close(@x, vl.x)
  end
end

class LineSegment < GeometryValue
  def ==(ls)
    self.class == ls.class and
    real_close_point(@x1,@y1,ls.x1,ls.y1) and
    real_close_point(@x2,@y2,ls.x2,ls.y2)
  end
end

class Intersect < GeometryExpression
  attr_reader :e1, :e2
  def ==(i)
    self.class == i.class and @e1 == i.e1 and @e2 == i.e2
  end
end

class Let < GeometryExpression
  attr_reader :s, :e1, :e2
  def ==(l)
    self.class == l.class and @s == l.s and @e1 == l.e1 and @e2 == l.e2
  end
end

class Var < GeometryExpression
  attr_reader :s
  def ==(v)
    self.class == v.class and @s == v.s
  end
end

class Shift < GeometryExpression
  attr_reader :dx, :dy, :e
  def ==(s)
    self.class == s.class and real_close_point(@dx, @dy, s.dx, s.dy) and @e == s.e
  end
end
