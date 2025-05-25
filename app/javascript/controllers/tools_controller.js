import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropZone", "postItButton"]
  static values = { whiteboardId: String }

  connect() {
    this.toggleFallbackUI()
  }

  toggleFallbackUI() {
    document.querySelectorAll('.tools-no-js').forEach(el => el.classList.add('hidden'))
    document.querySelectorAll('.tools-js').forEach(el => el.classList.remove('hidden'))
  }

  handleDragStart(e) {
    // Create a drag image
    const dragImage = document.createElement('div')
    dragImage.className = 'w-40 h-40 bg-yellow-200 shadow-lg rounded p-3'
    Object.assign(dragImage.style, {
        width: '160px',  // w-40 equivalent
        height: '160px', // h-40 equivalent
        position: 'fixed',
        left: '-9999px',
        pointerEvents: 'none'
      })
    dragImage.textContent = 'New note'
    document.body.appendChild(dragImage)
    e.dataTransfer.setDragImage(dragImage, 80, 80)
    
    // Set transfer data
    e.dataTransfer.effectAllowed = 'copy'
    e.dataTransfer.setData('text/plain', 'post-it')
    
    // Remove the drag image after a small delay
    setTimeout(() => document.body.removeChild(dragImage), 0)
  }

  allowDrop(e) {
    e.preventDefault()
    this.dropZoneTarget.classList.remove('border-gray-300', 'bg-gray-50')
    this.dropZoneTarget.classList.add('border-blue-500', 'bg-blue-50')
  }

  handleDragLeave() {
    this.dropZoneTarget.classList.remove('border-blue-500', 'bg-blue-50')
    this.dropZoneTarget.classList.add('border-gray-300', 'bg-gray-50')
  }

  handleDrop(e) {
    console.log("handleDrop")
    e.preventDefault()
    this.handleDragLeave()
    this.dropZoneTarget.classList.remove('bg-gray-100')
    
    const formData = new FormData()
    formData.append('post_it[x]', e.offsetX)
    formData.append('post_it[y]', e.offsetY)
    formData.append('post_it[color]', '#fef08a')
    formData.append('post_it[content]', 'New note')

    fetch(`/whiteboards/${this.whiteboardIdValue}/post_its`, {
      method: 'POST',
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      }
    })
  }

  endDrag(e) {
    this.proxyPostItTarget.classList.add('hidden')
    document.removeEventListener('mousemove', this.moveProxy)
  }

  disconnect() {
    document.removeEventListener('mousemove', this.moveProxy)
  }
}