class FaceToFaceOrderType < ActiveRecord::Migration
  def up
    OrderType.create(type_code: "FACE_TO_FACE", type_description: "Face To Face", org_id: FacilityOwner.first.id)
    HealthAgency.all.each{|ha|
      OrderType.create(type_code: "FACE_TO_FACE", type_description: "Face To Face", org_id: ha.id)
    }
  end

  def down
  end
end
