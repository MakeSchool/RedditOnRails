desc "This take updates submission scores"
task :update_scores => :environment do
  puts "Updating submission scores..."
    Submission.update_scores
  puts "Finished updating submission scores."
end
