## Changeable settings
@root = 'cv'
@compiler = 'xelatex'
@options = '-shell-escape -interaction=nonstopmode'
##
# Rest should not be edited
task :default => [:compile]

task :compile do
  puts "Compiling #{@root}..."
  compileStr = "#{@compiler} #{@options} #{@root}"
  system(compileStr + ' > output')

  task(:findErrors).invoke('output')
  task(:clean).invoke
end

task :clean do
  puts "Cleaning..."
  rm = 'rm -rf'
  tmp_all = %w[aux log nav snm tdo pyg lof lot fls fdb_latexmk toc vrb bbl bcf blg out bib.bak thm run.xml]
    .map{|f| '*.' + f}
    .join(' ')
  tmp_full = %W[output].join(' ')

  system("#{rm} #{tmp_all} #{tmp_full}") 
  system('rm -f **/*.aux')
  
  puts "Success!" unless @error
end

task :find_errors, :file do |t, args|
  @error = false 

  File.open(args[:file], 'r').each do |line|
    @error = true if line.include?('!')
  end

  if @error
    File.open(args[:file], 'r').each{|l| puts l}
    puts '---- ERROR COMPILING, CHECK ABOVE LOG ----'
  end
end
