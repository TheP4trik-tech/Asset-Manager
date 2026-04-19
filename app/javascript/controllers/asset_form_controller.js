import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
    static targets = ["buildingSelect", "roomSelect"]
    static values = {rooms: Array}

    connect() {
        console.log("asset form controller connected", this.roomsValue)
    }

    filterRooms(){
        let buildingID = parseInt(this.buildingSelectTarget.value)
        let filtered = this.roomsValue.filter(room => room.building_id == buildingID)
        this.roomSelectTarget.innerHTML = ""
        filtered.forEach(room => {
            let option = document.createElement("option")
            option.value = room.id
            option.innerText = room.name
            this.roomSelectTarget.appendChild(option)

        })
        if(filtered.length == 0){
            this.roomSelectTarget.innerHTML = "<option>Bez Místností</option>"
        }
    }

}