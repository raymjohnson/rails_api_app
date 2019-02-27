10.times do |n|
  RatingQuestion.create!(title: "Example Question #{n+=1}", tag:"rating question")
end
