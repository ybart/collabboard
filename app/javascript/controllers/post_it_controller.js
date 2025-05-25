import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: Number }
  static classes = ["dragging"] // Optional visual feedback

  initialize() {
    this.element.draggable = true
  }

  connect() {
    this.element.addEventListener('dragstart', this.dragStart.bind(this))
  }

  dragStart(e) {
    e.dataTransfer.setData("text/plain", this.idValue)
    e.dataTransfer.effectAllowed = "move"
    this.element.classList.add(this.draggingClass) // Visual feedback
  }

  async updatePosition(x, y) {
    try {
      const response = await fetch(`/post_its/${this.idValue}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
          'Accept': 'application/json'
        },
        body: JSON.stringify({ post_it: { x, y } })
      })
      
      if (!response.ok) throw new Error('Update failed')
    } catch (error) {
      console.error("Position update failed:", error)
      // Revert position visually if needed
    } finally {
      this.element.classList.remove(this.draggingClass)
    }
  }
}