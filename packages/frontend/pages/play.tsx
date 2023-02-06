import Head from 'next/head';
import { Landing } from '../components/contract/landing';
import { ConnectButton } from '@rainbow-me/rainbowkit';

export default function Play() {
  return (
    <div className={''}>
      <header className="p-1 bg-black">
        <ConnectButton />
      </header>
    </div>
  );
}