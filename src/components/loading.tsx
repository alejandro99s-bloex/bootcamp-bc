import React from 'react';
import styles from "../styles/components/Loading.module.css";

type SpinnerProps = {
  loading: boolean;
}

const Loading: React.FC<SpinnerProps> = ({ loading }) => {
  return (
    loading ? (
      <div className={styles.spinner_container}>
        <div className={styles.spinner}></div>
      </div>
    ) : null
  );
}

export default Loading;