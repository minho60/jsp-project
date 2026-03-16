
 
function createEvent(data) {
    return `
     <li>
      <div class="event-card" data-tab="${data.tab}">
        <div class="event-img">
          <a href="${data.link}">
            <img src="${data.image}" alt="${data.alt}">
          </a>
        </div>
        <div class="event-info">
          <div class="event-tit">
            <a href="${data.link}">
              <strong>${data.title}</strong>
            </a>
          </div>
          <div class="event-day">
            <strong>이벤트 기간</strong> ${data.date}
          </div>
        </div>
      </div>
    </li>
    `;
}

function renderEvents() {
  const eventList = document.getElementById("eventList");
  eventList.innerHTML = eventData.map(createEvent).join("");
}

renderEvents();

