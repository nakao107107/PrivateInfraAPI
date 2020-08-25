class MentorsController < ApplicationController
  def status
    mentor_status = []
    mentors = Mentor.where(group: params[:group]).all
    mentors.each do |mentor|
      problems = []

      #エンター情報系
      entors = mentor.entors
      entors.each do |entor|
        if entor.nickname == '' || entor.occupations.length == 0 || entor.industries.length == 0
          problems.push('エンター情報未記入')
          break
        end
      end

      #イベント系
      near_deadline_event_ids = Event.where('deadline <= ?', Time.current.since(7.days)).pluck(:id)
      done_event_ids = Progress.where(mentor_id: mentor.id).where(status: 'DONE').pluck('event_id')

      #near_deadline_event_idsがdone_event_idsに全て含まれる
      if not near_deadline_event_ids.to_set.subset?(done_event_ids.to_set)
        problems.push('イベント未訴求')
      end
      mentor_status.push(
          {
              name: mentor.name,
              problems: problems
          }
      )
    end
    render json: mentor_status
  end
end