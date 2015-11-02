class Article < ActiveRecord::Base
  require 'roo'
  #relationship
  has_many :comments, dependent: :destroy
  
  #avatar
  #avatar
  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.jpg"
  validates_attachment :avatar, size: {less_than: 1.megabytes}, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"]}
  #validation
  
  scope :status_active, -> {where(status: 'active')}
  
  def self.import_data(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    spreadsheet.sheets.each_with_index do |name, shit|
    spreadsheet.default_sheet = spreadsheet.sheets[shit]
    #debugger
     #spreadsheet.default_sheet = spreadsheet.sheets.last 
      (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      article = find_by_title(row["title"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      article.update_attributes(parameters.permit(:title, :content, :status, :comments_attributes => [:article_id, :content])) 
      end
    end
  end
  
 
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      parameters = ActionController::Parameters.new(row)
      article = find_by_title(row["title"]) || new
      article.update!(parameters.permit(:title, :content, :status))
      #article = find_by_title(row["title"])
      #article.comments.create!(parameters.permit(:article_id, :comment))
      #comment = article.comments.build
     spreadsheet.default_sheet = spreadsheet.sheets.last
      header = spreadsheet.row(1)     
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        parameters = ActionController::Parameters.new(row)
        comment = article.comments.find_by_comment(row["comment"]) || article.comments.build
        comment.update!(parameters.permit(:article_id, :comment))
        end
      end
  end
    
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
  end
  end
end
