// Selecting all the required elements
const startButton = document.getElementsByClassName("start")[0];
const stopButton = document.getElementsByClassName("stop")[0];
const resetButton = document.getElementsByClassName("reset")[0];
const lapButton = document.getElementsByClassName("lap")[0];

// Select individual time unit span elements to preserve styling
const hoursSpan = document.getElementsByClassName("hours")[0];
const minutesSpan = document.getElementsByClassName("minutes")[0];
const secondsSpan = document.getElementsByClassName("seconds")[0];
const millisecondsSpan = document.getElementsByClassName("milliseconds")[0];

console.log(startButton, stopButton, resetButton, lapButton);
console.log("Time spans:", hoursSpan, minutesSpan, secondsSpan, millisecondsSpan);

//Declaring time units variables
let hrs = 0, 
    mins = 0, 
    secs = 0,
    millisecs = 0,
    timeinterval,
    IsStart = false;

// Start button functionality
startButton.onclick = () => {
    // toggling between displaying Start and Stop buttons
    if (!IsStart) {
        startButton.style.display = "none";
        stopButton.style.display = "inline-block";
        IsStart = true;
    } else {
        startButton.style.display = "inline-block";
        stopButton.style.display = "none";
        IsStart = false;
    }
    timeinterval = setInterval(() => {
        millisecs++;
        if(millisecs == 100){
            secs++;
            millisecs = 0;
        }
        if(secs == 60){
            mins++;
            secs = 0;
        }
        if(mins == 60){
            hrs++;
            mins = 0;
        }
        
        // Update each span individually to preserve CSS styling
        // Format: Hours (always 2 digits)
        hoursSpan.textContent = hrs < 10 ? '0' + hrs : hrs;
        
        // Format: Minutes with leading colon (always 2 digits)
        minutesSpan.textContent = ':' + (mins < 10 ? '0' + mins : mins);
        
        // Format: Seconds with leading colon (always 2 digits)
        secondsSpan.textContent = ':' + (secs < 10 ? '0' + secs : secs);
        
        // Format: Milliseconds with leading colon (always 2 digits for display)
        millisecondsSpan.textContent = ':' + (millisecs < 10 ? '0' + millisecs : millisecs);
        
    }, 10);
};


// Stop button functionality
stopButton.onclick = () => {
    clearInterval(timeinterval);
    console.log("Stop button clicked - Timer stopped");
};

// Reset button functionality
resetButton.onclick = () => {
    clearInterval(timeinterval);
    hrs = 0;
    mins = 0; 
    secs = 0;
    millisecs = 0;
    
    // Reset display to initial state
    hoursSpan.textContent = '00';
    minutesSpan.textContent = ':00';
    secondsSpan.textContent = ':00';
    millisecondsSpan.textContent = ':00';
    
    console.log("Reset button clicked - Timer reset to 00:00:00:00");
};

// Lap button functionality
lapButton.onclick = () => {
    if (timeinterval) { // Only create lap if timer is running
        const lapTime = `${hrs < 10 ? '0' + hrs : hrs} : ${mins < 10 ? '0' + mins : mins} : ${secs < 10 ? '0' + secs : secs} : ${millisecs < 10 ? '0' + millisecs : millisecs}`;
        
        // Get existing laps list
        const lapsList = document.getElementsByClassName("laps")[0];
        const existingLaps = lapsList.querySelectorAll('.lap-item');
        const lapNumber = existingLaps.length;
        
        // Create new lap item
        const newLap = document.createElement('li');
        newLap.className = 'lap-item';
        newLap.innerHTML = `<span class="number">#${lapNumber + 1}</span><span>${lapTime}</span>`;
        
        // Insert new lap before the clear button
        const clearButton = lapsList.querySelector('.clear-laps');
        lapsList.insertBefore(newLap, clearButton);
        
        console.log(`Lap button clicked - Lap #${lapNumber + 1}: ${lapTime}`);
    }
};


