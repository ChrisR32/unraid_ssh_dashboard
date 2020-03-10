

# Basic menu class used to create an instance of a terminal menu
class Menu
  attr_accessor :width, :header, :body, :footer, :border_color, :word_wrap, :block_align
  def initialize(width: 50, header: nil, body: nil, footer: nil, border_color: 0)
    @width = width - 4 # adjust to allow '| ' and ' |' on each side
    @header = header
    @body = body
    @footer = footer
    @border_color = border_color
    @word_wrap = true
    @block_align = true
  end

  def display_menu
    # Return if nothing to display
    return unless @header || @body || @footer
    # Change left to ljust etc.
    align_to_method!
    print_line_break
    if @header
      display_header
      print_line_break
    end
    if @body
      display_body
      print_line_break
    end
    if @footer
      display_footer
      print_line_break
    end
  end

  def display_header
    print_text(@header[:text], @header[:align], @header[:color])
  end

  def display_body
    print_text(@body[:text], @body[:align], @body[:color])
    print_choices(@body[:choices], @body[:choice_align], @body[:color])
  end

  def display_footer
    print_text(@footer[:text], @footer[:align], @footer[:color])
  end

  private

  def print_text(text, align, color, choices: false)
    color = 0 if color.nil?
    # Default to center align
    align = 'center' if align.nil?
    # Split for normal text not for choices
    lines = choices ? text.dup : text.split("\n")
    # Wrap words or text that is too long
    lines.map! { |line| word_wrap(line) } if @word_wrap
    lines.flatten!
    # Check for longest line to allow for grouped alignment if enabled
    max_length = @block_align ? lines.map(&:length).max : 0
    # Add extra length for choices '1) '
    max_length += lines.count.to_s.length + 2 if choices
    lines.each_with_index do |line, i|
      line.prepend("#{i + 1}) ") if choices
      output = Rainbow('| ').fg(border_color)
      output += Rainbow(line.ljust(max_length).send(align, @width)).fg(color)
      output += Rainbow(' |').fg(border_color)
      puts output
    end
  end

  def print_choices(choices, align, color)
    print_text(choices, align, color, choices: true) unless choices.nil?
  end

  def print_line_break
    puts Rainbow('+' + '-' * (@width + 2) + '+').color(border_color)
  end

  def word_wrap(text)
    lines = text.split("\n")
    string = ''
    lines.each do |line|
      space_left = @width
      line.split.each do |word|
        if word.length + 1 > space_left
          string += "\n"
          if word.length > @width
            # Use regex to split word with newline when reaching max width
            word = word.scan(/.{1,#{@width}}/).join("\n")
          end
          string += word
          space_left = @width - word.length
        else
          string += " #{word}"
          space_left -= word.length + 1
        end
      end
      string += "\n"
    end
    string.strip.split("\n")
  end

  def align_to_method!
    @header[:align] = method_name(@header[:align]) if @header
    if @body
      @body[:align] = method_name(@body[:align])
      @body[:choice_align] = method_name(@body[:choice_align])
    end
    @footer[:align] = method_name(@footer[:align]) if @footer
  end

  def method_name(input = nil)
    return if input.nil?
    case input
    when 'left', 'ljust'
      'ljust'
    when 'right', 'rjust'
      'rjust'
    when 'center', 'middle'
      'center'
    end
  end
end