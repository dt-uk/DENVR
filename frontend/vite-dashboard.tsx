// M-DOD Tactical Dashboard - React/Vite/TypeScript
import { useState, useEffect } from 'react';
import * as d3 from 'd3';

interface DomainFeed {
  id: string;
  domain: 'LAND' | 'SEA' | 'AIR' | 'SPACE' | 'CYBER';
  status: 'ACTIVE' | 'WARNING' | 'CRITICAL';
  coordinates: [number, number];
}

export default function MDODDashboard() {
  const [feeds, setFeeds] = useState<DomainFeed[]>([]);
  const [threatLevel, setThreatLevel] = useState<number>(0);

  useEffect(() => {
    // Simulate real-time WebSocket feed
    const ws = new WebSocket('ws://localhost:8080/feed');
    ws.onmessage = (event) => {
      const data: DomainFeed[] = JSON.parse(event.data);
      setFeeds(data);
      setThreatLevel(data.filter(d => d.status === 'CRITICAL').length / data.length);
    };
    return () => ws.close();
  }, []);

  return (
    <div className="mdod-container">
      <h1>Multi-Domain Ops Dashboard</h1>
      <div className="threat-gauge">Threat Level: {(threatLevel * 100).toFixed(1)}%</div>
      <div className="domain-grid">
        {feeds.map(feed => (
          <DomainCard key={feed.id} feed={feed} />
        ))}
      </div>
    </div>
  );
}

function DomainCard({ feed }: { feed: DomainFeed }) {
  return <div className={`domain-card ${feed.status.toLowerCase()}`}>{feed.domain}</div>;
}
