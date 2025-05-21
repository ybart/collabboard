# Whiteboards
Whiteboard.destroy_all

3.times do |i|
  Whiteboard.create!(
    name: "Project Whiteboard #{i+1}",
    preview_image: "whiteboard-previews/sample#{i+1}.png"
  )
end

puts "Created #{Whiteboard.count} whiteboards"
